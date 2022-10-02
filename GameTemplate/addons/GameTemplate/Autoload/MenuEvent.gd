extends Node

signal Options
signal Controls
signal Languages
signal Paused
signal Refocus

#For section tracking
var options:bool = false :
  get:
    return options # TODOConverter40 Non existent get function 
  set(mod_value):
    mod_value  # TODOConverter40 Copy here content of set_options
var controls:bool = false :
  get:
    return controls # TODOConverter40 Non existent get function 
  set(mod_value):
    mod_value  # TODOConverter40 Copy here content of set_controls
var languages:bool = false :
  get:
    return languages # TODOConverter40 Non existent get function 
  set(mod_value):
    mod_value  # TODOConverter40 Copy here content of set_languages
var paused: bool = false :
  get:
    return paused # TODOConverter40 Non existent get function 
  set(mod_value):
    mod_value  # TODOConverter40 Copy here content of set_paused

func set_options(value:bool)->void:
  options = value
  emit_signal("Options", options)

func set_controls(value:bool)->void:
  controls = value
  emit_signal("Controls", controls)

func set_languages(value:bool)->void:
  languages = value
  emit_signal("Languages", languages)

func set_paused(value:bool)->void:
  paused = value
  get_tree().paused = value
  emit_signal("Paused", paused)

func _ready()->void:
  process_mode = Node.PROCESS_MODE_ALWAYS										#when pause menu allows reading inputs

func _input(event)->void:												#used to get back in menus
  if event.is_action_pressed("ui_cancel"):
    if languages:
      set_languages(false)
    elif controls:
      # ignore back button when entering key
      if !get_tree().get_nodes_in_group("KeyBinding")[0].visible:
        set_controls(false)
      else:
        return
    elif options:
      set_options(false)
      if PauseMenu.can_show:
        PauseMenu.show(true)
    elif paused:
      PauseMenu.show(false)
    elif PauseMenu.can_show:
      PauseMenu.show(true)
