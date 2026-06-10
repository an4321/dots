import { Extension } from 'resource:///org/gnome/shell/extensions/extension.js';
import * as Main from 'resource:///org/gnome/shell/ui/main.js';

export default class ThinPanelExtension extends Extension {
	enable() {
		// apply our custom css class to the main panel
		Main.panel.add_style_class_name('my-thin-panel');
	}

	disable() {
		// remove the css class when the extension is turned off
		Main.panel.remove_style_class_name('my-thin-panel');
	}
}
