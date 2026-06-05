class_name GameStateMachine
extends Node

enum State { MAIN_MENU, TRIO_SELECTION, SHOP, RUNNING, WAVE_END, DRAFT, EVENT, GAME_OVER, META_SHOP }

var current_state: State = State.MAIN_MENU
var previous_state: State = State.MAIN_MENU

signal state_changed(new_state: State, old_state: State)

func _ready() -> void:
	pass

func change_state(new_state: State) -> void:
	if new_state == current_state:
		return

	previous_state = current_state
	current_state = new_state
	state_changed.emit(current_state, previous_state)

func get_state_name(state: State) -> String:
	match state:
		State.MAIN_MENU:
			return "MainMenu"
		State.TRIO_SELECTION:
			return "TrioSelection"
		State.SHOP:
			return "Shop"
		State.RUNNING:
			return "Running"
		State.WAVE_END:
			return "WaveEnd"
		State.DRAFT:
			return "Draft"
		State.EVENT:
			return "Event"
		State.GAME_OVER:
			return "GameOver"
		State.META_SHOP:
			return "MetaShop"
		_:
			return "Unknown"

func is_in_run() -> bool:
	return current_state in [State.SHOP, State.RUNNING, State.WAVE_END, State.DRAFT, State.EVENT]
