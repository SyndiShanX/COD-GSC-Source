/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\loot.gsc
***********************************************/

init() {
  setsaveddvar("MQSNSOSMPN", 1);
  setdvarifuninitialized("debug_loot", 0);
  level.loot = spawnStruct();
  level.loot.types = [];
  level.loot.items = [];
  level.loot.spawned = [];
  level.loot.notifications = [];
  level.loot.lastloottime = 0;
  level.loot.spawntags = ["j_spinelower"];
  level.loot.sfx = scripts\engine\utility::spawn_script_origin(level.player.origin);
  level.loot.sfx linkTo(level.player);
  level.loot.offhands = [];

  if(scripts\common\utility::playerarmorenabled()) {
    precacheshader("ui_icon_armor_pickup");
    registerloot("Ballistic Vest", "hud_icon_loot_armor", "Armor", "loot_armor", "loot_pickup_armor", 1, ::lootarmor, ::playermaxarmor, ::probabilityarmor);
    thread updatearmordroptimer();
  }

  registerammoloot("Rocket", "hud_icon_loot_ammo_rocket", "Rocket", "loot_ammo_rocket", "loot_pickup_ammo_sniper", "rocket");
  registerammoloot("40mm Grenade", "hud_icon_loot_ammo_40mmgrenade", "40mm Grenade", "loot_ammo_40mmgrenade", "loot_pickup_ammo_sniper", "40mmGrenade");
  registeroffhandloot("M67 Frag", "hud_icon_equipment_frag", &"EQUIPMENT/LOOT_FRAG", "loot_frag", "frag");
  registeroffhandloot("Semtex", "hud_icon_equipment_semtex", &"EQUIPMENT/LOOT_SEMTEX", "loot_semtex", "semtex");
  registeroffhandloot("M84 Flash", "hud_icon_equipment_flash", &"EQUIPMENT/LOOT_FLASH", "loot_flash", "flash");
  registeroffhandloot("Molotov", "hud_icon_equipment_molotov", &"EQUIPMENT/LOOT_MOLOTOV", "loot_molotov", "molotov");
  registerloot("Throwing Knife", "hud_icon_equipment_throwing_knife", &"EQUIPMENT/LOOT_THROWING_KNIFE", "loot_throwingknife", "loot_pickup_offhand", 1, ::donothing, ::inactive, ::probabilityzero);
  thread setworldloot();
}

corpselootthink() {
  if(!cancarryloot()) {
    return;
  }
  if(!worldmaxspawnedloot())
    onspawnloot();

  self waittill("death", var_0);

  if(!shoulddroploot(var_0)) {
    return;
  }
  spawncorpseloot();
}

cancarryloot() {
  if(!isDefined(self))
    return 0;

  if(!isDefined(level.loot))
    return 0;

  if(self.team != "axis")
    return 0;

  if(self.classname == "actor_enemy_dog")
    return 0;

  if(self.classname == "actor_enemy_alq_desert_bomber")
    return 0;

  if(self.classname == "actor_enemy_alq_urban_bomber")
    return 0;

  return 1;
}

shoulddroploot(var_0) {
  if(!isDefined(self))
    return 0;

  if(!isDefined(level.loot))
    return 0;

  if(!scripts\sp\utility::playerlootenabled())
    return 0;

  if(force_armor_drop())
    return 1;

  if(indonotspawnlootvolume(self))
    return 0;

  if(istrue(self.noloot))
    return 0;

  if(!scripts\engine\utility::is_equal(var_0, level.player))
    return 0;

  if(worldmaxspawnedloot())
    return 0;

  return 1;
}

onspawnloot() {
  self.loot = [];

  foreach(var_2, var_1 in level.loot.types) {
    if(isDefined(level.loot.types[var_2].onspawnfunc)) {
      if([[level.loot.types[var_2].probabilityfunc]](var_2, self.origin)) {
        self thread[[level.loot.types[var_2].onspawnfunc]]();
        self.loot[var_2] = 1;
      }
    }
  }
}

registerloot(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  precacheshader(var_1);
  precachemodel(var_3);
  level.loot.types[var_0] = spawnStruct();
  level.loot.types[var_0].shader = var_1;
  level.loot.types[var_0].loc = var_2;
  level.loot.types[var_0].model = var_3;
  level.loot.types[var_0].sound = var_4;
  level.loot.types[var_0].createnotification = var_5;
  level.loot.types[var_0].lootfunc = var_6;
  level.loot.types[var_0].inactivefunc = var_7;
  level.loot.types[var_0].probabilityfunc = var_8;
  level.loot.types[var_0].onspawnfunc = var_9;
  level.loot.types[var_0].weapon = var_10;
}

deregisterloot(var_0) {
  level.loot.types[var_0] = undefined;
  level.loot.types = scripts\engine\utility::array_remove_key(level.loot.types, var_0);
}

registerammoloot(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_5 == "rocket")
    var_6 = ::probabilityzero;
  else if(var_5 == "40mmGrenade")
    var_6 = ::probabilityzero;
  else
    var_6 = ::probabilityzero;

  registerloot(var_0, var_1, var_2, var_3, var_4, 1, ::lootammo, ::playermaxammo, var_6);
}

registeroffhandloot(var_0, var_1, var_2, var_3, var_4) {
  registerloot(var_0, var_1, var_2, var_3, "loot_pickup_offhand", 1, ::lootoffhand, ::inactiveoffhand, ::probabilityoffhand, undefined, var_4);
}

removeoffhandloot(var_0) {
  if(isstring(var_0))
    var_1 = var_0;
  else
    var_1 = var_0.basename;

  var_2 = scripts\sp\equipment\offhands::getweaponoffhandtype(var_1);

  if(isDefined(level.loot.offhands[var_2]))
    level.loot.offhands = scripts\engine\utility::array_remove_key(level.loot.offhands, var_2);
}

setoffhandloot(var_0) {
  if(isstring(var_0))
    var_1 = var_0;
  else
    var_1 = var_0.basename;

  var_2 = scripts\sp\equipment\offhands::getweaponoffhandtype(var_1);

  if(isDefined(level.loot.offhands[var_2]))
    level.loot.offhands = scripts\engine\utility::array_remove_key(level.loot.offhands, var_2);

  level.loot.offhands[var_2] = var_1;
}

updatearmordroptimer() {
  level.player endon("death");
  level.loot.lastdroppedarmortime = -60000;
  level.loot.armordroptimer = 0;

  for(;;) {
    if(level.player enemynearplayer() && !level.player scripts\sp\player::hasarmor())
      level.loot.armordroptimer = level.loot.armordroptimer + 0.05;

    waitframe();
  }
}

enemynearplayer() {
  foreach(var_1 in getaiarray("axis")) {
    if(distancesquared(self.origin, var_1.origin) <= 1048576)
      return 1;
  }

  return 0;
}

worldmaxspawnedloot() {
  if(level.loot.spawned.size >= 25) {
    if(trylootdropdespawn())
      return 0;

    return 1;
  }

  return 0;
}

trylootdropdespawn() {
  var_0 = level.loot.items;
  var_1 = sortbydistance(var_0, level.player.origin)[var_0.size - 1];

  for(;;) {
    if(!var_0.size)
      return 0;

    var_1 = sortbydistance(var_0, level.player.origin)[var_0.size - 1];

    if(!isDefined(var_1))
      return 0;

    if(!itemworldplaced(var_1)) {
      break;
    }

    var_0 = scripts\engine\utility::array_remove(var_0, var_1);
  }

  if(!itemworldplaced(var_1) && distancesquared(var_1.origin, level.player.origin) > distancesquared(self.origin, level.player.origin)) {
    var_1 cleanuplootitem();
    return 1;
  }

  return 0;
}

trylootdespawn(var_0) {
  var_1 = undefined;
  var_2 = -1;

  foreach(var_4 in level.loot.items) {
    if(!scripts\engine\utility::is_equal(var_4.name, var_0)) {
      continue;
    }
    if(itemworldplaced(var_4)) {
      continue;
    }
    var_5 = distancesquared(var_4.origin, level.player.origin);

    if(level.player scripts\engine\math::point_in_fov(var_4.origin) && var_5 < 2250000) {
      continue;
    }
    if(!isDefined(var_1) || var_5 > var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  if(isDefined(var_1) && distancesquared(self.origin, level.player.origin) < var_2) {
    var_1 cleanuplootitem();
    return 1;
  }

  return 0;
}

spawncorpseloot() {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.loot))
    self.loot = [];

  var_0 = self.loot.size;

  foreach(var_7, var_2 in level.loot.types) {
    if(var_0 >= 2) {
      break;
    }

    var_3 = isDefined(level.loot.types[var_7].onspawnfunc);
    var_4 = istrue(self.loot[var_7]);
    var_5 = [[level.loot.types[var_7].probabilityfunc]](var_7, self.origin);

    if(!var_3 && !var_4 && var_5) {
      var_6 = level.loot.spawntags[randomint(level.loot.spawntags.size)];
      spawnlootitem(var_7, self gettagorigin(var_6), undefined, 685, 0);
      var_0++;
    }
  }
}

spawnlootitem(var_0, var_1, var_2, var_3, var_4) {
  if(tolower(var_0) == "ballistic vest" && !scripts\common\utility::playerarmorenabled()) {
    return;
  }
  if(!isDefined(var_2))
    var_2 = scripts\engine\utility::randomvectorrange(0, 360);

  var_5 = scripts\sp\script_items::scriptitem_buildspawnflags(0, 1, 1, 0, 1);
  var_6 = level.loot.types[var_0].model;
  var_7 = (randomfloat(0.5), randomfloat(0.5), 1) * var_3;
  var_8 = spawnscriptitem("script_item_" + var_0, var_1, var_2, var_5, var_6, "", var_7, var_1);

  if(isDefined(var_8)) {
    setitemasloot(var_8, var_0, var_4);
    return var_8;
  }
}

setitemasloot(var_0, var_1, var_2) {
  var_0.name = var_1;
  var_0.worldplaced = var_2;
  var_0 thread cleanuplootitemondelete();
  var_0 thread checkforlootitemtrigger(var_1);
  level.loot.items = scripts\engine\utility::array_add(level.loot.items, var_0);

  if(!isDefined(var_2) || !var_2)
    level.loot.spawned = scripts\engine\utility::array_add(level.loot.spawned, var_0);
}

itemworldplaced(var_0) {
  return var_0.worldplaced;
}

cleanuplootitemondelete() {
  self waittill("death");
  cleanuplootitem();
}

cleanuplootitem() {
  safedelete();
  level.loot.items = scripts\engine\utility::array_removeundefined(level.loot.items);
  level.loot.spawned = scripts\engine\utility::array_removeundefined(level.loot.spawned);
}

safedelete() {
  if(isDefined(self))
    self delete();
}

checkforlootitemtrigger(var_0) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_1);

    if(var_1 != level.player) {
      continue;
    }
    waittillplayercanloot();
    waittillnextloottime();

    if([[level.loot.types[var_0].inactivefunc]](var_0)) {
      continue;
    }
    lootfuncandnotification(var_0);
    self delete();
  }
}

lootfuncandnotification(var_0) {
  level.player thread[[level.loot.types[var_0].lootfunc]](var_0);
  level.player notify("item_loot");
  playlootsound(var_0);

  if(level.loot.types[var_0].createnotification && !scripts\engine\sp\utility::in_realism_mode())
    thread createnotification(level.loot.types[var_0].shader, level.loot.types[var_0].loc);
}

lootnearbyitems(var_0, var_1, var_2) {
  foreach(var_4 in level.loot.items) {
    if(scripts\engine\utility::is_equal(var_1, var_4)) {
      continue;
    }
    if(!scripts\engine\utility::is_equal(var_2, var_4.name)) {
      continue;
    }
    if(distancesquared(var_0, var_4.origin) <= 16384) {
      level.player thread[[level.loot.types[var_4.name].lootfunc]](var_4.name);
      var_4 delete();
    }
  }
}

playermaxarmor(var_0) {
  return level.player scripts\sp\player::hasmaxarmorvests();
}

playermaxammo(var_0) {
  return level.player scripts\sp\player::getammonameamount(var_0) >= level.player scripts\sp\player::getammonamemaxamount(var_0);
}

inactiveoffhand(var_0) {
  var_1 = getoffhandweaponname(var_0);

  if(!isDefined(var_1)) {}

  if(!scripts\engine\sp\utility::player_has_equipment(var_1)) {
    var_2 = scripts\sp\equipment\offhands::getweaponoffhandtype(var_1);

    if(!player_offhand_empty(var_2))
      return 1;
  }

  return level.player getweaponammostock(var_1) == weaponmaxammo(var_1);
}

inactive(var_0) {
  return 0;
}

player_offhand_empty(var_0) {
  var_1 = level.player getcurrentoffhand(var_0);

  if(!isDefined(var_1) || var_1.basename == "none")
    return 1;
  else
    return 0;
}

getoffhandprobabilityfromname(var_0) {
  return 40;
}

getoffhandweaponname(var_0) {
  return level.loot.types[var_0].weapon;
}

lootammo(var_0) {
  var_1 = scripts\sp\player::getammonameamount(var_0);
  var_2 = scripts\sp\player::getammonamemaxamount(var_0);
  var_3 = getammolootamount(var_1, var_2);
  var_4 = int(min(var_2, var_1 + var_3));

  if(var_4 != var_1)
    level.player scripts\sp\player::setammonameamount(var_0, var_4);
}

getammolootamount(var_0, var_1) {
  var_2 = scripts\engine\math::normalize_value(0, var_1, var_0);
  var_3 = scripts\engine\math::factor_value(0.5, 0.1, var_2);
  return max(1, int(var_3 * var_1));
}

lootarmor(var_0) {
  var_1 = level.player scripts\sp\player::getarmorvestamount();
  level.player scripts\sp\player::set_armor_vest_amount(var_1 + 1);
}

lootoffhand(var_0) {
  var_1 = getoffhandweaponname(var_0);

  if(!isDefined(var_1)) {}

  if(scripts\engine\sp\utility::player_has_equipment(var_1, 1)) {
    var_2 = level.player getweaponammostock(var_1);
    var_3 = weaponmaxammo(var_1);
    var_4 = int(min(var_2 + 1, var_3));
    level.player setweaponammoclip(var_1, var_4);
  } else
    level.player scripts\engine\sp\utility::give_offhand(var_1, 1);
}

donothing(var_0) {}

probabilityarmor(var_0, var_1) {
  if(istrue(self.noarmor))
    return 0;

  if(force_armor_drop())
    return 1;

  return 0;
}

armorinventoryratio() {
  var_0 = 1 - level.player scripts\sp\player::getarmorvestamount() / level.player scripts\sp\player::getarmorvestmaxamount();
  return 0.15 * var_0;
}

armorhealthratio() {
  var_0 = 1 - level.player scripts\sp\player::getarmoramount() / level.player scripts\sp\player::getarmormaxamount();
  return 0.1 * var_0;
}

armordistanceratio(var_0) {
  var_1 = 0.000000444444;
  var_2 = var_1 * var_0;
  return 0.75 * var_2;
}

armormaxprobability() {
  var_0 = min(level.loot.armordroptimer / 120, 1);
  var_1 = 82 * var_0;
  return 3 + var_1;
}

probabilityzero(var_0, var_1) {
  return 0;
}

get_stowed_primary_weapon() {
  foreach(var_1 in self.primaryinventory) {
    if(!isnullweapon(var_1, self.currentprimaryweapon, 1))
      return var_1;
  }

  return isundefinedweapon();
}

probabilityoffhand(var_0, var_1) {
  var_2 = getoffhandweaponname(var_0);

  if(!isDefined(var_2)) {}

  if(!scripts\engine\utility::array_contains(level.loot.offhands, var_2))
    return 0;

  var_3 = distancesquared(var_1, level.player.origin);

  if(var_3 > 2250000)
    return 0;

  var_4 = getoffhandprobabilityfromname(var_0);

  if(!isDefined(var_4)) {}

  var_5 = 0;

  if(scripts\engine\sp\utility::player_has_equipment(var_2))
    var_5 = level.player getweaponammostock(var_2);

  var_6 = weaponmaxammo(var_2);

  if(var_5 >= var_6)
    var_7 = 0;
  else
    var_7 = var_4 * (1 - var_5 / var_6);

  if(randomint(100) > var_7)
    return 0;

  var_8 = 0;

  foreach(var_10 in level.loot.items) {
    if(scripts\engine\utility::is_equal(var_10.name, var_0) && !itemworldplaced(var_10))
      var_8++;
  }

  var_12 = var_8 + var_5 >= var_6;

  if(!var_12)
    return 1;

  if(trylootdespawn(var_0))
    return 1;
  else
    return 0;
}

waittillplayercanloot() {
  while(level.player ismeleeing())
    waitframe();
}

playlootsound(var_0) {
  level.loot.sfx scripts\engine\utility::delaycall(0.2, ::playsound, level.loot.types[var_0].sound);
}

createnotification(var_0, var_1) {
  var_2 = undefined;
  var_3 = 600;
  var_4 = 300;

  for(var_5 = 0; var_5 < level.loot.notifications.size; var_5++) {
    if(level.loot.notifications[var_5].locname == var_1) {
      var_2 = level.loot.notifications[var_5];
      var_2 notify("stop_fading");
      var_4 = var_2.icon.y;
    }
  }

  var_6 = 224.0;
  var_7 = 432.0;
  var_8 = newhudelem();
  var_8.x = var_6;
  var_8.y = var_7;
  var_8.alignx = "right";
  var_8.aligny = "top";
  var_8.sort = 2;
  var_8.alpha = 0;
  var_8 setshader(var_0, 22, 22);
  var_8.shader = var_0;
  var_9 = newhudelem();
  var_9.x = var_6;
  var_9.y = var_7 + 5;
  var_9.alignx = "left";
  var_9.aligny = "top";
  var_9.font = "hudsmall";
  var_9.fontscale = 0.75;
  var_9.alpha = 0;
  var_9 settext(var_1);
  var_8 fadeovertime(0.15);
  var_8 moveovertime(0.215);
  var_8.alpha = 0.8;
  var_8.x = var_3;
  var_8.y = var_4;
  var_9 fadeovertime(0.15);
  var_9 moveovertime(0.215);
  var_9.alpha = 1;
  var_9.x = var_3;
  var_9.y = var_4 + 5;
  var_10 = spawnStruct();
  var_10.icon = var_8;
  var_10.text = var_9;
  var_10.locname = var_1;

  if(!isDefined(var_2))
    level.loot.notifications[level.loot.notifications.size] = var_10;

  level.player scripts\engine\utility::waittill_notify_or_timeout("death", 0.215);

  if(isDefined(var_2)) {
    thread notificationdisplayandfade(var_2, var_0);
    wait 0.05;
    var_10 destroylootnotification();
  } else {
    foreach(var_12 in level.loot.notifications) {
      var_12.icon.y = var_12.icon.y - 22;
      var_12.text.y = var_12.text.y - 22;
    }

    thread notificationdisplayandfade(var_10, var_0);
  }
}

notificationdisplayandfade(var_0, var_1) {
  var_0 notify("reset");
  var_0 endon("death");
  var_0 endon("stop_fading");
  var_0 endon("reset");
  var_0 thread notificationpulse();
  var_0.icon.alpha = 0.8;
  var_0.text.alpha = 1;

  if(isalive(level.player))
    level.player scripts\engine\utility::waittill_notify_or_timeout("death", 3);
  else {
    var_0 destroylootnotification();
    return;
  }

  var_0.icon.alpha = 0.8;
  var_0.text.alpha = 1;

  for(var_2 = gettime() + 500.0; isalive(level.player) && gettime() < var_2; var_0.text.alpha = var_0.text.alpha - 0.1) {
    wait 0.05;
    var_0.icon.alpha = var_0.icon.alpha - 0.1;
  }

  var_0 destroylootnotification();
}

notificationpulse() {
  var_0 = 2;
  self.icon scaleovertime(0.05, 30, 30);
  self.icon moveovertime(0.05);
  self.icon.y = self.icon.y - var_0;
  self.icon.x = self.icon.x + var_0;
  wait 0.05;

  if(isDefined(self) && isDefined(self.icon)) {
    self.icon scaleovertime(0.15, 22, 22);
    self.icon moveovertime(0.15);
    self.icon.y = self.icon.y + var_0;
    self.icon.x = self.icon.x - var_0;
  }
}

waittillnextloottime() {
  var_0 = gettime();
  var_1 = level.loot.lastloottime + 250;

  if(var_0 > var_1)
    level.loot.lastloottime = var_0;
  else {
    level.loot.lastloottime = var_1;

    while(gettime() < var_1)
      waitframe();
  }
}

destroylootnotification() {
  if(scripts\engine\utility::array_contains(level.loot.notifications, self))
    level.loot.notifications = scripts\engine\utility::array_remove(level.loot.notifications, self);

  self.icon destroy();
  self.text destroy();
  self.name = undefined;
  self notify("death");
}

setworldloot() {
  waittillframeend;

  foreach(var_1 in scripts\engine\utility::getStructArray("lootSpawn", "targetname")) {
    if(!isrefloot())
      spawnlootitem(var_1.script_noteworthy, var_1.origin, var_1.angles, 0, 1);
  }
}

isrefloot() {
  if(isDefined(self.spawnflags) && self.spawnflags & 1)
    return 1;
  else
    return 0;
}

createpickupicon(var_0) {
  self endon("death");
  self endon("entitydeleted");

  while(distancesquared(level.player.origin, self.origin) > 2250000)
    waitframe();

  target_alloc(self, (0, 0, 10));
  target_drawsquare(self);
  target_drawsingle(self);
  target_setcolor(self, (1, 1, 1), 0);
  target_setscaledrendermode(self, 0);
  target_showtoplayer(self, level.player);
  target_setshader(self, var_0);
  target_flush(self);
  childthread updatepickupicon();
}

updatepickupicon() {
  self.alpha = 0;
  self.iconsize = 0;
  var_0 = gettime();

  for(;;) {
    var_1 = distance(level.player.origin, self.origin);
    var_2 = gettime() < var_0 + 2150;
    var_3 = isalive(level.player) && level.player scripts\engine\trace::can_see_origin(self.origin + (0, 0, 10), 0);

    if(var_2 || var_3) {
      var_4 = 1 - scripts\engine\math::normalize_value(0, 1000, var_1);
      var_5 = var_4 * 1.25;
    } else
      var_5 = 0;

    if(var_5 != self.alpha) {
      var_6 = clamp((var_5 - self.alpha) * 0.45, -0.125, 0.125);
      var_7 = self.alpha + var_6;
      target_setcolor(self, (1, 1, 1), var_7);
      self.alpha = var_7;
    }

    var_8 = scripts\engine\math::normalize_value(100, 1000, var_1);
    var_9 = int(scripts\engine\math::factor_value(32, 8, var_8) * 1);

    if(var_9 != self.iconsize) {
      target_setminsize(self, var_9, 0);
      target_setmaxsize(self, var_9, 0);
      self.iconsize = var_9;
    }

    waitframe();
  }
}

indonotspawnlootvolume(var_0) {
  var_1 = getEntArray("doNotSpawnLoot", "targetname");

  foreach(var_3 in var_1) {
    if(var_0 istouching(var_3))
      return 1;
  }

  return 0;
}

set_force_armor_drop(var_0) {
  self.lootforcearmordrop = var_0;
}

force_armor_drop() {
  return istrue(self.lootforcearmordrop);
}