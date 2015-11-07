/**************************************************************************************
 * ProScene (version 3.0.0)
 * Copyright (c) 2010-2014 National University of Colombia, https://github.com/remixlab
 * @author Jean Pierre Charalambos, http://otrolado.info/
 * 
 * All rights reserved. Library that eases the creation of interactive scenes
 * in Processing, released under the terms of the GNU Public License v3.0
 * which is available at http://www.gnu.org/licenses/gpl.html
 **************************************************************************************/

package remixlab.proscene;

import processing.core.PApplet;
import remixlab.bias.event.KeyboardEvent;
import remixlab.dandelion.branch.*;

/**
 * Proscene key-agent. A {@link remixlab.dandelion.branch.KeyboardAgent} specialization
 * which handles Processing key-events.
 * 
 * @see remixlab.dandelion.branch.KeyboardAgent
 * @see remixlab.proscene.MouseAgent
 * @see remixlab.proscene.DroidKeyAgent
 * @see remixlab.proscene.DroidTouchAgent
 */
public class KeyAgent extends KeyboardAgent {
	protected boolean				press, release, type;
	protected KeyboardEvent	currentEvent;

	/**
	 * Calls super on (scn,n) and sets default keyboard shortcuts.
	 * 
	 * @see #setDefaultBindings()
	 */
	public KeyAgent(GenericScene scn, String n) {
		super(scn, n);
		LEFT_KEY = PApplet.LEFT;
		RIGHT_KEY = PApplet.RIGHT;
		UP_KEY= PApplet.UP;
		DOWN_KEY= PApplet.DOWN;
		setDefaultBindings();
	}

	/**
	 * Processing keyEvent method to be registered at the PApplet's instance.
	 */
	public void keyEvent(processing.event.KeyEvent e) {
		press = e.getAction() == processing.event.KeyEvent.PRESS;
		release = e.getAction() == processing.event.KeyEvent.RELEASE;
		type = e.getAction() == processing.event.KeyEvent.TYPE;
		currentEvent = new KeyboardEvent(e.getKey(), e.getModifiers(), e.getKeyCode());
		if (press) {
			updateTrackedGrabber(currentEvent);
			handle(currentEvent);
		}
	}

	@Override
	public int keyCode(char key) {
		return java.awt.event.KeyEvent.getExtendedKeyCodeForChar(key);
	}
}