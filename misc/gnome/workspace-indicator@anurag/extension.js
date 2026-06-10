import { Extension } from 'resource:///org/gnome/shell/extensions/extension.js';
import * as Main from 'resource:///org/gnome/shell/ui/main.js';
import * as PanelMenu from 'resource:///org/gnome/shell/ui/panelMenu.js';
import St from 'gi://St';
import Clutter from 'gi://Clutter';

export default class WorkspaceSquareIndicator extends Extension {
	enable() {
		this._activitiesButton = Main.panel.statusArea.activities;
		if (this._activitiesButton) {
			this._activitiesButton.hide();
		}

		this._indicator = new PanelMenu.Button(0.0, this.metadata.name, false);

		this._indicator.reactive = false;
		this._indicator.can_focus = false;

		this._box = new St.BoxLayout({
			y_align: Clutter.ActorAlign.CENTER,
			style: 'spacing: 6px; padding: 0 4px;',
			reactive: false,
			can_focus: false,
		});
		this._indicator.add_child(this._box);

		Main.panel.addToStatusArea('workspace-square-indicator', this._indicator, 0, 'left');

		this._workspaceManager = global.workspace_manager;

		this._activeChangedId = this._workspaceManager.connect(
			'active-workspace-changed',
			this._updateWorkspaces.bind(this)
		);
		this._numberChangedId = this._workspaceManager.connect(
			'number-of-workspaces-changed',
			this._updateWorkspaces.bind(this)
		);
		this._windowCreatedId = global.display.connect(
			'window-created',
			this._updateWorkspaces.bind(this)
		);
		this._focusWindowId = global.display.connect(
			'notify::focus-window',
			this._updateWorkspaces.bind(this)
		);
	}

	disable() {
		if (this._activitiesButton) {
			this._activitiesButton.show();
			this._activitiesButton = null;
		}

		if (this._activeChangedId) {
			this._workspaceManager.disconnect(this._activeChangedId);
			this._activeChangedId = null;
		}
		if (this._numberChangedId) {
			this._workspaceManager.disconnect(this._numberChangedId);
			this._numberChangedId = null;
		}
		if (this._windowCreatedId) {
			global.display.disconnect(this._windowCreatedId);
			this._windowCreatedId = null;
		}
		if (this._focusWindowId) {
			global.display.disconnect(this._focusWindowId);
			this._focusWindowId = null;
		}

		if (this._indicator) {
			this._indicator.destroy();
			this._indicator = null;
		}

		this._box = null;
		this._workspaceManager = null;
	}

	_updateWorkspaces() {
		this._box.destroy_all_children();

		const numWorkspaces = this._workspaceManager.n_workspaces;
		const activeIndex = this._workspaceManager.get_active_workspace_index();

		for (let i = 0; i < numWorkspaces; i++) {
			const workspace = this._workspaceManager.get_workspace_by_index(i);
			const windows = workspace.list_windows().filter(w => !w.is_skip_taskbar());
			const isNonEmpty = windows.length > 0;
			const isActive = i === activeIndex;

			if (!isActive && !isNonEmpty) continue;

			const label = new St.Label({
				text: (i + 1).toString(),
				y_align: Clutter.ActorAlign.CENTER,
				x_align: Clutter.ActorAlign.CENTER,
				reactive: false,
				can_focus: false,
			});

			if (isActive) {
				label.set_style(
					'border-radius: 6px;' +
					'background-color: #3f4142;' +
					'color: #ffffff;' +
					'font-weight: bold;' +
					'padding: 1px 10px;'
				);
			} else {
				label.set_style(
					'color: #ffffff;' +
					'font-weight: bold;' +
					'padding: 1px 4px;'
				);
			}

			this._box.add_child(label);
		}
	}
}
