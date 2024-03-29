/*********************************************************************************
 * bias_tree
 * Copyright (c) 2014 National University of Colombia, https://github.com/remixlab
 * @author Jean Pierre Charalambos, http://otrolado.info/
 *
 * All rights reserved. Library that eases the creation of interactive
 * scenes, released under the terms of the GNU Public License v3.0
 * which is available at http://www.gnu.org/licenses/gpl.html
 *********************************************************************************/

package remixlab.bias.branch;

import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

import remixlab.bias.core.BogusEvent;
import remixlab.bias.core.Shortcut;
import remixlab.util.*;

/**
 * A mapping defining {@link remixlab.bias.core.Shortcut} to {@link remixlab.bias.branch.Action}
 * bindings, implemented as a parameterized hash-map wrap. Profiles are internally used by
 * {@link remixlab.bias.branch.Branch}es to parse {@link remixlab.bias.core.BogusEvent}s into
 * {@link remixlab.bias.branch.GenericGrabber} object {@link remixlab.bias.branch.Action}s.
 *
 * @param <A> User-defined {@link remixlab.bias.branch.Action}.
 * 
 * @param <E> 'Reference' enum action set, used to parameterize the user-defined action.
 * 
 * @param <K> {@link remixlab.bias.core.Shortcut}
 *
 */
public class Profile<E extends Enum<E>, K extends Shortcut, A extends Action<E>> implements Copyable {
	@Override
	public int hashCode() {
		return new HashCodeBuilder(17, 37).append(map).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (obj == null)
			return false;
		if (obj == this)
			return true;
		if (obj.getClass() != getClass())
			return false;

		Profile<?, ?, ?> other = (Profile<?, ?, ?>) obj;
		return new EqualsBuilder().append(map, other.map).isEquals();
	}

	protected HashMap<K, A>	map;

	/**
	 * Constructs the hash-map based profile.
	 */
	public Profile() {
		map = new HashMap<K, A>();
	}

	/**
	 * Copy constructor. Use {@link #get()} to copy this profile.
	 * 
	 * @param other
	 *          profile to be copied
	 */
	protected Profile(Profile<E, K, A> other) {
		map = new HashMap<K, A>();
		for (Map.Entry<K, A> entry : other.map().entrySet()) {
			K key = entry.getKey();
			A value = entry.getValue();
			setBinding(key, value);
		}
	}

	/**
	 * Returns a deep-copy of this profile.
	 */
	@Override
	public Profile<E, K, A> get() {
		return new Profile<E, K, A>(this);
	}

	/**
	 * Main class method which attempts to define a user-defined action by parsing the event's shortcut.
	 * 
	 * @param event
	 *          {@link remixlab.bias.core.BogusEvent} i.e., Action event to be parsed by this profile.
	 * @return The user-defined action. May be null if no actions was found.
	 */
	public A handle(BogusEvent event) {
		if (event != null)
			return action(event.shortcut());
		return null;
	}

	/**
	 * Returns the {@code map} (which is simply an instance of {@code HashMap}) encapsulated by this object.
	 */
	public HashMap<K, A> map() {
		return map;
	}

	/**
	 * Returns the {@link remixlab.bias.branch.Action} binding for the given {@link remixlab.bias.core.Shortcut}
	 * key.
	 */
	public A action(Shortcut key) {
		return map.get(key);
	}

	/**
	 * Defines the shortcut that triggers a given action.
	 * 
	 * @param key
	 *          {@link remixlab.bias.core.Shortcut}
	 * @param action
	 *          {@link remixlab.bias.branch.Action}
	 */
	public void setBinding(K key, A action) {
		if (hasBinding(key)) {
			A a = action(key);
			if(a != action)
				System.out.println("Warning: overwritting shortcut which was previously bound to " + a);
			else
				System.out.println("Warning: shortcut already bound to " + a);
		}
		map.put(key, action);
	}

	/**
	 * Removes the shortcut binding.
	 * 
	 * @param key
	 *          {@link remixlab.bias.core.Shortcut}
	 */
	public void removeBinding(K key) {
		map.remove(key);
	}

	/**
	 * Removes all the shortcuts from this object.
	 */
	public void removeBindings() {
		map.clear();
	}

	/**
	 * Returns true if this object contains a binding for the specified shortcut.
	 * 
	 * @param key
	 *          {@link remixlab.bias.core.Shortcut}
	 * @return true if this object contains a binding for the specified shortcut.
	 */
	public boolean hasBinding(K key) {
		return map.containsKey(key);
	}

	/**
	 * Returns true if this object maps one or more shortcuts to the specified action.
	 * 
	 * @param action
	 *          {@link remixlab.bias.branch.Action}
	 * @return true if this object maps one or more shortcuts to the specified action.
	 */
	public boolean isActionBound(A action) {
		return map.containsValue(action);
	}

	/**
	 * Returns a description of all the bindings this profile holds.
	 */
	public String description() {
		String result = new String();
		boolean title = false;
		for (Entry<K, A> entry : map.entrySet())
			if (entry.getKey() != null && entry.getValue() != null) {
				if(!title) {
				  result += entry.getKey().getClass().getSimpleName() + "s:\n";
				  title = true;
				}
				result += entry.getKey().description() + " -> " + entry.getValue().description() + "\n";
			}
		return result;
	}
}
