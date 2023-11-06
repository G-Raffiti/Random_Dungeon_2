class_name SkillTree
extends Resource

var upgrades: Array[Upgrade] = []

func _init(ability_resource: Ability_Resource):
  for upgrade in ability_resource.upgrades:
    upgrades.append(upgrade.duplicate(true))
  upgrades.shuffle()
  upgrades.sort_custom(func(a,b): return a.rarity < b.rarity)

  var a: Array[Upgrade] = []
  var b: Array[Upgrade] = []
  var c: Array[Upgrade] = []
  for upgrade in upgrades:
    if (randf() < 0.33):
      a.append(upgrade)
    elif (randf() < 0.66):
      b.append(upgrade)
    else:
      c.append(upgrade)
  
  # Y branch
  for i in a.size():
    if (i == 0): continue
    if (i == 1):
      a[i].requirements.append(a[0])
      continue
    if (randf() < 0.5):
      a[i].requirements.append(a[i-1])
    else:
      a[i].requirements.append(a[i-2])
  
  # O branch
  for i in b.size() - 1:
    if (i == 0): continue
    b[i].requirements.append(b[i-1])
    b[i + 1].requirements.append(b[i])
  
  # OY branch
  for i in c.size():
    if (i == 0):
      c[i].requirements.append(b[b.size() / 2])
      b[b.size() / 2].requirements.append(c[i])
      continue
    if (i == 1):
      c[i].requirements.append(c[0])
      continue
    if (randf() < 0.5):
      c[i].requirements.append(c[i-1])
    else:
      c[i].requirements.append(c[i-2])
