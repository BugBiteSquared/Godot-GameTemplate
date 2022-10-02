extends Node

signal Resized

#SCREEN
var Fullscreen = false :
  get:
    return Fullscreen # TODOConverter40 Non existent get function 
  set(mod_value):
    mod_value  # TODOConverter40 Copy here content of set_fullscreen
var Borderless = false :
  get:
    return Borderless # TODOConverter40 Non existent get function 
  set(mod_value):
    mod_value  # TODOConverter40 Copy here content of set_borderless
var View:Window
var ViewRect2:Rect2
var GameResolution:Vector2
var WindowResolution:Vector2
var ScreenResolution:Vector2
var ScreenAspectRatio:float
var Scale:int = 3:
  set = set_scale				#Default scale multiple
var MaxScale:int

#RESOLUTION
func set_fullscreen(value:bool)->void:
  Fullscreen = value
  #if value:
  #  DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
  #else:
  #  DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
  #if value:
  #  set_scale(MaxScale)
  #else:
  #  OS.center_window()
  #  set_scale(OS.window_size.x/GameResolution.x)

func set_borderless(value:bool)->void:
  Borderless = value
  DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, value)

func get_resolution()->void:
  View = get_viewport()
  ViewRect2 = View.get_visible_rect()
  GameResolution = ViewRect2.size
  
  WindowResolution = DisplayServer.window_get_size()#OS.window_size
  ScreenResolution = DisplayServer.screen_get_size(DisplayServer.window_get_current_screen())#OS.get_screen_size(OS.current_screen)
  ScreenAspectRatio = ScreenResolution.x/ScreenResolution.y
  MaxScale = ceil(ScreenResolution.y/ GameResolution.y)

func set_scale(value:int)->void:
  Scale = clamp(value, 1, MaxScale)
  if Scale >= MaxScale:
    #if true:
    DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
    Fullscreen = true
  else:
    DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
    Fullscreen = false
    DisplayServer.window_set_size(GameResolution * Scale)
    center_window()
  get_resolution()
  emit_signal("Resized")

func center_window():
  var window_position = DisplayServer.screen_get_position(0) + DisplayServer.screen_get_size(0)/2 - DisplayServer.window_get_size()/2
  DisplayServer.window_set_position(window_position)

#SAVING RESOLUTION
func get_resolution_data()->Dictionary:
  var resolution_data:Dictionary = {}
  resolution_data["Borderless"] = Borderless
  resolution_data["Scale"] = Scale
  return resolution_data

#LOADING RESOLUTION

func set_resolution_data(resolution:Dictionary)->void:
  SettingsResolution.set_borderless(resolution.Borderless)
  SettingsResolution.set_scale(resolution.Scale)
