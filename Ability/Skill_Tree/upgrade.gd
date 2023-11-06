class_name Upgrade
extends Resource

@export var rarity: G.Rarity = G.Rarity.COMMON
@export var stats: Dictionary = {}
@export var name: String = ""
@export var description: String = ""
@export var icon: Texture2D = null

func _init(_name: String, _description: String, _stats: Dictionary, _icon: Texture2D, _rarity: G.Rarity):
  name = _name
  description = _description
  stats = _stats
  icon = _icon
  rarity = _rarity

var requirements: Array[Upgrade] = []
var level: int = 0
