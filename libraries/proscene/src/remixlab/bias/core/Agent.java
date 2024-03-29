/*********************************************************************************
 * bias_tree
 * Copyright (c) 2014 National University of Colombia, https://github.com/remixlab
 * @author Jean Pierre Charalambos, http://otrolado.info/
 *
 * All rights reserved. Library that eases the creation of interactive
 * scenes, released under the terms of the GNU Public License v3.0
 * which is available at http://www.gnu.org/licenses/gpl.html
 *********************************************************************************/

package remixlab.bias.core;

import java.util.ArrayList;
import java.util.List;

import remixlab.bias.event.*;

/**
 * Agents gather data from different sources --mostly from input devices such touch surfaces or simple mice--
 * and reduce them into a rather simple but quite 'useful' set of interface events ({@link remixlab.bias.core.BogusEvent})
 * for third party objects ({@link remixlab.bias.core.Grabber} objects) to consume them ({@link #handle(BogusEvent)}).
 * Agents thus effectively open up a channel between all kinds of input data sources and user-space objects. To add/remove
 * a grabber to/from the #grabbers() collection issue #addGrabber(Grabber) / #removeGrabber(Grabber) calls.
 * Derive from this agent and either call {@link #handle(BogusEvent)} or override {@link #handleFeed()}.
 * <p>
 * The agent may send bogus-events to its {@link #inputGrabber()} which may be regarded as the agent's grabber target. The
 * {@link #inputGrabber()} may be set by querying each grabber object in {@link #grabbers()} to check if its
 * {@link remixlab.bias.core.Grabber#checkIfGrabsInput(BogusEvent)}) condition is met
 * (see {@link #updateTrackedGrabber(BogusEvent)}, {@link #updateTrackedGrabberFeed()}). The first grabber meeting
 * the condition, namely the {@link #trackedGrabber()}), will then be set as the {@link #inputGrabber()}. When no
 * grabber meets the condition, the {@link #trackedGrabber()} is then set to null. In this case, a non-null
 * {@link #inputGrabber()} may still be set with {@link #setDefaultGrabber(Grabber)} (see also {@link #defaultGrabber()}).
 */
public abstract class Agent {
	public static int LEFT_ID	= 1, CENTER_ID = 2, RIGHT_ID = 3, WHEEL_ID = 4;
	public static int LEFT_KEY	= 1, RIGHT_KEY = 2, UP_KEY = 3, DOWN_KEY = 4;
	
	protected String										nm;	
	protected List<Grabber>	grabberList;	
	protected Grabber trackedGrabber, defaultGrabber;
	protected boolean							agentTrckn;
	protected InputHandler							handler;

	/**
	 * Constructs an Agent with the given name and registers is at the given inputHandler.
	 */
	public Agent(InputHandler inputHandler, String name) {
		nm = name;
		grabberList = new ArrayList<Grabber>();
		setTracking(true);
		handler = inputHandler;
		handler.registerAgent(this);
	}

	/**
	 * @return agent's name
	 */
	public String name() {
		return nm;
	}
	
	// 1. Grabbers

	/**
	 * Removes the grabber from the {@link #grabbers()} list.
	 * 
	 * @see #removeGrabbers()
	 * @see #addGrabber(Grabber)
	 * @see #hasGrabber(Grabber)
	 * @see #grabbers()
	 */	
	public boolean removeGrabber(Grabber grabber) {
		if(defaultGrabber() == grabber)
			setDefaultGrabber(null);
		if(trackedGrabber() == grabber)
			trackedGrabber = null;
		return grabberList.remove(grabber);
	}

	/**
	 * Clears the {@link #grabbers()} list.
	 * 
	 * @see #removeGrabber(Grabber)
	 * @see #addGrabber(Grabber)
	 * @see #hasGrabber(Grabber)
	 * @see #grabbers()
	 */	
	public void removeGrabbers() {
		setDefaultGrabber(null);
		trackedGrabber = null;
		//tGrabberBranch = null;		
		grabberList.clear();
	}
	
	/**
	 * Returns the list of grabber (and interactive-grabber) objects handled by this agent.
	 * 
	 * @see #removeGrabber(Grabber)
	 * @see #addGrabber(Grabber)
	 * @see #hasGrabber(Grabber)
	 * @see #removeGrabbers()
	 */
	public List<Grabber> grabbers() {
		List<Grabber> pool = new ArrayList<Grabber>();		
		pool.removeAll(grabberList);
		pool.addAll(grabberList);
		return pool;
	}

	/**
	 * Returns true if the grabber is currently in the agents {@link #grabbers()} list.
	 * 
	 * @see #removeGrabber(Grabber)
	 * @see #addGrabber(Grabber)
	 * @see #grabbers()
	 * @see #removeGrabbers()
	 */
	public boolean hasGrabber(Grabber grabber) {
		if (grabber == null)
			return false;
		// return grabbers().contains(grabber);
		// /*
		for (Grabber g : grabbers())
			if (g == grabber)
				return true;
		return false;
		// */
	}

	/**
	 * Adds the grabber in {@link #grabbers()}.
	 * 
	 * @see #removeGrabber(Grabber)
	 * @see #hasGrabber(Grabber)
	 * @see #grabbers()
	 * @see #removeGrabbers()
	 */
	public boolean addGrabber(Grabber grabber) {
		if (grabber == null)
			return false;
		if (hasGrabber(grabber))
			return false;
		return grabberList.add(grabber);
	}

	/**
	 * Returns a String with a detailed description of this Agent.
	 */
	public String info() {
		String description = new String();
		description += name();
		description += "\n";
		return description;
	}
	
	/**
	 * Feeds {@link #updateTrackedGrabber(BogusEvent)} and {@link #handle(BogusEvent)} with the returned event.
	 * Returns null by default. Use it in place of {@link #updateTrackedGrabberFeed()} and/or {@link #handleFeed()}
	 * which take higher-precedence.
	 * <p>
	 * Automatically call by the main event loop ({@link remixlab.bias.core.InputHandler#handle()}).
	 * See ProScene's Space-Navigator example.
	 * 
	 * @see remixlab.bias.core.InputHandler#handle()
	 * @see #handleFeed()
	 * @see #updateTrackedGrabberFeed()
	 * @see #handle(BogusEvent)
	 * @see #updateTrackedGrabber(BogusEvent)
	 */
	protected BogusEvent feed() {
		return null;
	}

	/**
	 * Feeds {@link #handle(BogusEvent)} with the returned event. Returns null by default. Use it in place of
	 * {@link #feed()} which takes lower-precedence.
	 * <p>
	 * Automatically call by the main event loop ({@link remixlab.bias.core.InputHandler#handle()}).
	 * See ProScene's Space-Navigator example.
	 * 
	 * @see remixlab.bias.core.InputHandler#handle()
	 * @see #feed()
	 * @see #updateTrackedGrabberFeed()
	 * @see #handle(BogusEvent)
	 * @see #updateTrackedGrabber(BogusEvent)
	 */
	protected BogusEvent handleFeed() {
		return null;
	}
	
	/**
	 * Feeds {@link #updateTrackedGrabber(BogusEvent)} with the returned event. Returns null by default.  Use it
	 * in place of {@link #feed()} which takes lower-precedence.
	 * <p>
	 * Automatically call by the main event loop ({@link remixlab.bias.core.InputHandler#handle()}).
	 * 
	 * @see remixlab.bias.core.InputHandler#handle()
	 * @see #feed()
	 * @see #handleFeed()
	 * @see #handle(BogusEvent)
	 * @see #updateTrackedGrabber(BogusEvent)
	 */
	protected BogusEvent updateTrackedGrabberFeed() {
		return null;
	}

	/**
	 * Returns the {@link remixlab.bias.core.InputHandler} this agent is registered to.
	 */
	public InputHandler inputHandler() {
		return handler;
	}	

	/**
	 * If {@link #isTracking()} and the agent is registered at the {@link #inputHandler()} then queries each
	 * object in the {@link #grabbers()} to check if the {@link remixlab.bias.core.Grabber#checkIfGrabsInput(BogusEvent)})
	 * condition is met. The first object meeting the condition will be set as the {@link #inputGrabber()} and returned.
	 * Note that a null grabber means that no object in the {@link #grabbers()} met the condition. A
	 * {@link #inputGrabber()} may also be enforced simply with {@link #setDefaultGrabber(Grabber)}.
	 * 
	 * @param event to query the {@link #grabbers()}
	 * @return the new grabber which may be null.
	 * 
	 * @see #setDefaultGrabber(Grabber)
	 * @see #isTracking()
	 * @see #handle(BogusEvent)
	 * @see #trackedGrabber()
	 * @see #defaultGrabber()
	 * @see #inputGrabber()
	 */
	protected Grabber updateTrackedGrabber(BogusEvent event) {
		if (event == null || !inputHandler().isAgentRegistered(this) || !isTracking())
			return trackedGrabber();
		Grabber g = trackedGrabber();
		// We first check if tracked grabber remains the same
		if (g != null)
			if (g.checkIfGrabsInput(event))
				return trackedGrabber();
		// pick the first otherwise
		trackedGrabber = null;
		for (Grabber grabber : grabberList) {
			if(grabber.checkIfGrabsInput(event)) {
				trackedGrabber = grabber;
				return trackedGrabber();
			}
		}
		return trackedGrabber();
	}

	/**
	 * Returns the sensitivities used in {@link #handle(BogusEvent)} to {@link remixlab.bias.event.MotionEvent#modulate(float[])}.
	 */
	public float[] sensitivities(MotionEvent event) {
		return new float[] { 1f, 1f, 1f, 1f, 1f, 1f };
	}

	/**
	 * Enqueues an EventGrabberTuple(event, inputGrabber()) on the {@link remixlab.bias.core.InputHandler#eventTupleQueue()},
	 * thus enabling a call on the {@link #inputGrabber()} {@link remixlab.bias.core.Grabber#performInteraction(BogusEvent)} method
	 * (which is scheduled for execution till the end of this main event loop iteration, see
	 * {@link remixlab.bias.core.InputHandler#enqueueEventTuple(EventGrabberTuple)} for details).
	 * 
	 * @see #inputGrabber()
	 * @see #updateTrackedGrabber(BogusEvent)
	 */
	protected boolean handle(BogusEvent event) {
		if (event == null || !handler.isAgentRegistered(this) || inputHandler() == null)
			return false;
		if (event instanceof MotionEvent)
			if (((MotionEvent) event).isAbsolute())
				if (event.isNull() && !event.flushed())
					return false;
		if (event instanceof MotionEvent)
			((MotionEvent) event).modulate(sensitivities((MotionEvent) event));
		Grabber inputGrabber = inputGrabber();
		if (inputGrabber != null)
			return inputHandler().enqueueEventTuple(new EventGrabberTuple(event, inputGrabber));
		return false;
	}

	/**
	 * If {@link #trackedGrabber()} is non null, returns it. Otherwise returns the {@link #defaultGrabber()}.
	 * 
	 * @see #trackedGrabber()
	 */
	public Grabber inputGrabber() {
		return trackedGrabber() != null ? trackedGrabber() : defaultGrabber();
	}

	/**
	 * Returns true if {@code g} is the agent's {@link #inputGrabber()} and false otherwise.
	 */
	public boolean isInputGrabber(Grabber g) {
		return inputGrabber() == g;
	}

	/**
	 * Returns {@code true} if this agent is tracking its grabbers.
	 * <p>
	 * You may need to {@link #enableTracking()} first.
	 */
	public boolean isTracking() {
		return agentTrckn;
	}

	/**
	 * Enables tracking so that the {@link #inputGrabber()} may be updated when calling
	 * {@link #updateTrackedGrabber(BogusEvent)}.
	 * 
	 * @see #disableTracking()
	 */
	public void enableTracking() {
		setTracking(true);
	}

	/**
	 * Disables tracking.
	 * 
	 * @see #enableTracking()
	 */
	public void disableTracking() {
		setTracking(false);
	}

	/**
	 * Sets the {@link #isTracking()} value.
	 */
	public void setTracking(boolean enable) {
		agentTrckn = enable;
		if (!isTracking())
			trackedGrabber = null;
	}

	/**
	 * Calls {@link #setTracking(boolean)} to toggle the {@link #isTracking()} value.
	 */
	public void toggleTracking() {
		setTracking(!isTracking());
	}

	/**
	 * Returns the grabber set after {@link #updateTrackedGrabber(BogusEvent)} is called. It may be null.
	 */
	public Grabber trackedGrabber() {
		return trackedGrabber;
	}

	/**
	 * Default {@link #inputGrabber()} returned when {@link #trackedGrabber()} is null and set with
	 * {@link #setDefaultGrabber(Grabber)}.
	 * 
	 * @see #inputGrabber()
	 * @see #trackedGrabber()
	 */
	public Grabber defaultGrabber() {
		return defaultGrabber;
	}
	
	/**
	 * Same as {@code defaultGrabber() != g1 ? setDefaultGrabber(g1) ? true : setDefaultGrabber(g2) : setDefaultGrabber(g2)} which
	 * is ubiquitous among the examples.
	 */
    public boolean shiftDefaultGrabber(Grabber g1, Grabber g2) {
    	return defaultGrabber() != g1 ? setDefaultGrabber(g1) ? true : setDefaultGrabber(g2) : setDefaultGrabber(g2); 
	}

	/**
	 * Sets the {@link #defaultGrabber()}
	 * 
	 * {@link #inputGrabber()}
	 */
	public boolean setDefaultGrabber(Grabber grabber) {
		if (grabber == null) {
			this.defaultGrabber = null;
			return true;
		}
		if( ! hasGrabber(grabber) ) {
			System.err.println("To set a default grabber the object should be added into agent first. Use one of the agent addGrabber() methods");
			return false;
		}
		if(grabberList.contains(grabber)) {
			this.defaultGrabber = grabber;
			return true;
		}
		return false;
	}
	
	/**
	 * Sets the {@link #trackedGrabber()} to {@code null}.
	 */
	public void resetTrackedGrabber() {
		trackedGrabber = null;
	}

	/**
	 * Resets the {@link #defaultGrabber()}. Convenience function that simply calls: {@code setDefaultGrabber(null)}.
	 * 
	 * @see #setDefaultGrabber(Grabber)
	 */
	public boolean resetDefaultGrabber() {
		return setDefaultGrabber(null);
	}
}