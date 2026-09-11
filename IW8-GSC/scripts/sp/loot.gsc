/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\loot.gsc
***********************************************/

function init() {
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
    registerloot("Ballistic Vest", "hud_icon_loot_armor", "Armor", "loot_armor", "loot_pickup_armor", 1, &lootarmor, &playermaxarmor, &probabilityarmor);
    thread updatearmordroptimer();
  }

  registerammoloot("Rocket", "hud_icon_loot_ammo_rocket", "Rocket", "loot_ammo_rocket", "loot_pickup_ammo_sniper", "rocket");
  registerammoloot("40mm Grenade", "hud_icon_loot_ammo_40mmgrenade", "40mm Grenade", "loot_ammo_40mmgrenade", "loot_pickup_ammo_sniper", "40mmGrenade");
  registeroffhandloot("M67 Frag", "hud_icon_equipment_frag", &"EQUIPMENT/LOOT_FRAG", "loot_frag", "frag");
  registeroffhandloot("Semtex", "hud_icon_equipment_semtex", &"EQUIPMENT/LOOT_SEMTEX", "loot_semtex", "semtex");
  registeroffhandloot("M84 Flash", "hud_icon_equipment_flash", &"EQUIPMENT/LOOT_FLASH", "loot_flash", "flash");
  registeroffhandloot("Molotov", "hud_icon_equipment_molotov", &"EQUIPMENT/LOOT_MOLOTOV", "loot_molotov", "molotov");
  registerloot("Throwing Knife", "hud_icon_equipment_throwing_knife", &"EQUIPMENT/LOOT_THROWING_KNIFE", "loot_throwingknife", "loot_pickup_offhand", 1, &donothing, &inactive, &probabilityzero);
  thread setworldloot();
}

function corpselootthink() {
  if(!cancarryloot()) {
    return;
  }

  jumpiftrue(worldmaxspawnedloot()) LOC_00000015;
  onspawnloot();
  self waittill("death", var0);

  if(!shoulddroploot(var0)) {
    return;
  }

  spawncorpseloot();
}

function cancarryloot() {
  if(!isDefined(self)) {
    return false;
  }

  if(!isDefined(level.loot)) {
    return false;
  }

  if(self.team != "axis") {
    return false;
  }

  if(self.classname == "actor_enemy_dog") {
    return false;
  }

  if(self.classname == "actor_enemy_alq_desert_bomber") {
    return false;
  }

  if(self.classname == "actor_enemy_alq_urban_bomber") {
    return false;
  }

  return true;
}

function shoulddroploot(var0) {
  if(!isDefined(self)) {
    return false;
  }

  if(!isDefined(level.loot)) {
    return false;
  }

  if(!scripts\sp\utility::playerlootenabled()) {
    return false;
  }

  if(force_armor_drop()) {
    return true;
  }

  if(indonotspawnlootvolume(self)) {
    return false;
  }

  if(istrue(self.noloot)) {
    return false;
  }

  if(!scripts\engine\utility::is_equal(var0, level.player)) {
    return false;
  }

  if(worldmaxspawnedloot()) {
    return false;
  }

  return true;
}

function onspawnloot() {
  self.loot = [];

  foreach(var2, var1 in level.loot.types) {
    if(isDefined(level.loot.types[var2].onspawnfunc)) {
      if([[level.loot.types[var2].probabilityfunc]](var2, self.origin)) {
        self thread[[level.loot.types[var2].onspawnfunc]]();
        self.loot[var2] = 1;
      }
    }
  }
}

function registerloot(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  precacheshader(var1);
  precachemodel(var3);
  level.loot.types[var0] = spawnStruct();
  level.loot.types[var0].shader = var1;
  level.loot.types[var0].loc = var2;
  level.loot.types[var0].model = var3;
  level.loot.types[var0].sound = var4;
  level.loot.types[var0].createnotification = var5;
  level.loot.types[var0].lootfunc = var6;
  level.loot.types[var0].inactivefunc = var7;
  level.loot.types[var0].probabilityfunc = var8;
  level.loot.types[var0].onspawnfunc = var9;
  level.loot.types[var0].weapon = var10;
}

function deregisterloot(var0) {
  level.loot.types[var0] = undefined;
  level.loot.types = scripts\engine\utility::array_remove_key(level.loot.types, var0);
}

function registerammoloot(var0, var1, var2, var3, var4, var5) {
  if(var5 == "rocket") {
    var6 = &probabilityzero;
  } else if(var6 == "40mmGrenade") {
    var6 = &probabilityzero;
  } else {
    var6 = &probabilityzero;
  }

  registerloot(var2, var3, var4, var5, var6, 1, &lootammo, &playermaxammo, var6);
}

function registeroffhandloot(var0, var1, var2, var3, var4) {
  registerloot(var0, var1, var2, var3, "loot_pickup_offhand", 1, &lootoffhand, &inactiveoffhand, &probabilityoffhand, undefined, var4);
}

function removeoffhandloot(var0) {
  if(isstring(var0)) {
    var1 = var0;
  } else {
    var1 = var1.basename;
  }

  var2 = scripts\sp\equipment\offhands::getweaponoffhandtype(var1);

  if(isDefined(level.loot.offhands[var2])) {
    level.loot.offhands = scripts\engine\utility::array_remove_key(level.loot.offhands, var2);
    return;
  }
}

function setoffhandloot(var0) {
  if(isstring(var0)) {
    var1 = var0;
  } else {
    var1 = var1.basename;
  }

  var2 = scripts\sp\equipment\offhands::getweaponoffhandtype(var1);

  if(isDefined(level.loot.offhands[var2])) {
    level.loot.offhands = scripts\engine\utility::array_remove_key(level.loot.offhands, var2);
  }

  level.loot.offhands[var2] = var1;
}

function updatearmordroptimer() {
  level.player endon("death");
  level.loot.lastdroppedarmortime = -60000;
  level.loot.armordroptimer = 0;

  for(;;) {
    if(enemynearplayer(level.player) && !level.player scripts\sp\player::hasarmor()) {
      level.loot.armordroptimer += 0.05;
    }

    waitframe();
  }
}

function enemynearplayer() {
  foreach(var1 in getaiarray("axis")) {
    if(distancesquared(self.origin, var1.origin) <= 1048576) {
      return true;
    }
  }

  return false;
}

function worldmaxspawnedloot() {
  if(level.loot.spawned.size >= 25) {
    if(trylootdropdespawn()) {
      return false;
    }

    return true;
  }

  return false;
}

function trylootdropdespawn() {
  var0 = level.loot.items;
  var1 = sortbydistance(var0, level.player.origin)[var0.size - 1];

  for(;;) {
    if(!var0.size) {
      return false;
    }

    var1 = sortbydistance(var0, level.player.origin)[var0.size - 1];

    if(!isDefined(var1)) {
      return false;
    }

    if(!itemworldplaced(var1)) {
      break;
    }

    var0 = scripts\engine\utility::array_remove(var0, var1);
  }

  if(!itemworldplaced(var1) && distancesquared(var1.origin, level.player.origin) > distancesquared(self.origin, level.player.origin)) {
    cleanuplootitem(var1);
    return true;
  }

  return false;
}

function trylootdespawn(var0) {
  var1 = undefined;
  var2 = -1;

  foreach(var4 in level.loot.items) {
    if(!scripts\engine\utility::is_equal(var4.name, var0)) {
      continue;
    }

    if(itemworldplaced(var4)) {
      continue;
    }

    var5 = distancesquared(var4.origin, level.player.origin);

    if(level.player scripts\engine\math::point_in_fov(var4.origin) && var5 < 2250000) {
      continue;
    }

    if(!isDefined(var1) || var5 > var2) {
      var1 = var4;
      var2 = var5;
    }
  }

  if(isDefined(var1) && distancesquared(self.origin, level.player.origin) < var2) {
    cleanuplootitem(var1);
    return true;
  }

  return false;
}

function spawncorpseloot() {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.loot)) {
    self.loot = [];
  }

  var0 = self.loot.size;

  foreach(var7, var2 in level.loot.types) {
    if(var0 >= 2) {
      break;
    }

    var3 = isDefined(level.loot.types[var7].onspawnfunc);
    var4 = istrue(self.loot[var7]);
    var5 = [[level.loot.types[var7].probabilityfunc]](var7, self.origin);

    if(!var3 && !var4 && var5) {
      var6 = level.loot.spawntags[randomint(level.loot.spawntags.size)];
      spawnlootitem(var7, self gettagorigin(var6), undefined, 685, 0);
      var0++;
    }
  }
}

function spawnlootitem(var0, var1, var2, var3, var4) {
  if(tolower(var0) == "ballistic vest" && !scripts\common\utility::playerarmorenabled()) {
    return;
  }

  if(!isDefined(var2)) {
    var2 = scripts\engine\utility::randomvectorrange(0, 360);
  }

  var5 = scripts\sp\script_items::scriptitem_buildspawnflags(0, 1, 1, 0, 1);
  var6 = level.loot.types[var0].model;
  var7 = (randomfloat(0.5), randomfloat(0.5), 1) * var3;
  var8 = spawnscriptitem("script_item_" + var0, var1, var2, var5, var6, "", var7, var1);

  if(isDefined(var8)) {
    setitemasloot(var8, var0, var4);
    return var8;
  }
}

function setitemasloot(var0, var1, var2) {
  var0.name = var1;
  var0.worldplaced = var2;
  thread cleanuplootitemondelete();
  thread checkforlootitemtrigger(var0);
  level.loot.items = scripts\engine\utility::array_add(level.loot.items, var0);

  if(!isDefined(var2) || !var2) {
    level.loot.spawned = scripts\engine\utility::array_add(level.loot.spawned, var0);
    return;
  }
}

function itemworldplaced(var0) {
  return var0.worldplaced;
}

function cleanuplootitemondelete() {
  self waittill("death");
  cleanuplootitem();
}

function cleanuplootitem() {
  safedelete();
  level.loot.items = scripts\engine\utility::array_removeundefined(level.loot.items);
  level.loot.spawned = scripts\engine\utility::array_removeundefined(level.loot.spawned);
}

function safedelete() {
  if(isDefined(self)) {
    self delete();
    return;
  }
}

function checkforlootitemtrigger(var0) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var1);

    if(var1 != level.player) {
      continue;
    }

    waittillplayercanloot();
    waittillnextloottime();

    if([[level.loot.types[var0].inactivefunc]](var0)) {
      continue;
    }

    lootfuncandnotification(var0);
    self delete();
  }
}

function lootfuncandnotification(var0) {
  level.player thread[[level.loot.types[var0].lootfunc]](var0);
  level.player notify("item_loot");
  playlootsound(var0);

  if(level.loot.types[var0].createnotification && !scripts\engine\sp\utility::in_realism_mode()) {
    thread createnotification(level.loot.types[var0].shader, level.loot.types[var0].loc);
    return;
  }
}

function lootnearbyitems(var0, var1, var2) {
  foreach(var4 in level.loot.items) {
    if(scripts\engine\utility::is_equal(var1, var4)) {
      continue;
    }

    if(!scripts\engine\utility::is_equal(var2, var4.name)) {
      continue;
    }

    if(distancesquared(var0, var4.origin) <= 16384) {
      level.player thread[[level.loot.types[var4.name].lootfunc]](var4.name);
      var4 delete();
    }
  }
}

function playermaxarmor(var0) {
  return level.player scripts\sp\player::hasmaxarmorvests();
}

function playermaxammo(var0) {
  return level.player scripts\sp\player::getammonameamount(var0) >= level.player scripts\sp\player::getammonamemaxamount(var0);
}

function inactiveoffhand(var0) {
  var1 = getoffhandweaponname(var0);

  if(isDefined(var1)) {}

  if(!scripts\engine\sp\utility::player_has_equipment(var1)) {
    var2 = scripts\sp\equipment\offhands::getweaponoffhandtype(var1);

    if(!player_offhand_empty(var2)) {
      return true;
    }
  }

  return level.player getweaponammostock(var1) == weaponmaxammo(var1);
}

function inactive(var0) {
  return false;
}

function player_offhand_empty(var0) {
  var1 = level.player getcurrentoffhand(var0);

  if(!isDefined(var1) || var1.basename == "none") {
    return 1;
  }

  return 0;
}

function getoffhandprobabilityfromname(var0) {
  return 40;
}

function getoffhandweaponname(var0) {
  return level.loot.types[var0].weapon;
}

function lootammo(var0) {
  var1 = scripts\sp\player::getammonameamount(var0);
  var2 = scripts\sp\player::getammonamemaxamount(var0);
  var3 = getammolootamount(var1, var2);
  var4 = int(min(var2, var1 + var3));

  if(var4 != var1) {
    level.player scripts\sp\player::setammonameamount(var0, var4);
    return;
  }
}

function getammolootamount(var0, var1) {
  var2 = scripts\engine\math::normalize_value(0, var1, var0);
  var3 = scripts\engine\math::factor_value(0.5, 0.1, var2);
  return max(1, int(var3 * var1));
}

function lootarmor(var0) {
  var1 = level.player scripts\sp\player::getarmorvestamount();
  level.player scripts\sp\player::set_armor_vest_amount(var1 + 1);
}

function lootoffhand(var0) {
  var1 = getoffhandweaponname(var0);

  if(isDefined(var1)) {}

  if(scripts\engine\sp\utility::player_has_equipment(var1, 1)) {
    var2 = level.player getweaponammostock(var1);
    var3 = weaponmaxammo(var1);
    var4 = int(min(var2 + 1, var3));
    level.player setweaponammoclip(var1, var4);
    return;
  }

  level.player scripts\engine\sp\utility::give_offhand(var1, 1);
}

function donothing(var0) {}

function probabilityarmor(var0, var1) {
  if(istrue(self.noarmor)) {
    return false;
  }

  if(force_armor_drop()) {
    return true;
  }

  return false;
}

function armorinventoryratio() {
  var0 = 1 - level.player scripts\sp\player::getarmorvestamount() / level.player scripts\sp\player::getarmorvestmaxamount();
  return 0.15 * var0;
}

function armorhealthratio() {
  var0 = 1 - level.player scripts\sp\player::getarmoramount() / level.player scripts\sp\player::getarmormaxamount();
  return 0.1 * var0;
}

function armordistanceratio(var0) {
  var1 = 4.44444e-07;
  var2 = var1 * var0;
  return 0.75 * var2;
}

function armormaxprobability() {
  var0 = min(level.loot.armordroptimer / 120, 1);
  var1 = 82 * var0;
  return 3 + var1;
}

function probabilityzero(var0, var1) {
  return false;
}

function get_stowed_primary_weapon() {
  foreach(var1 in self.primaryinventory) {
    if(!isnullweapon(var1, self.currentprimaryweapon, 1)) {
      return var1;
    }
  }

  return isundefinedweapon();
}

function probabilityoffhand(var0, var1) {
  var2 = getoffhandweaponname(var0);

  if(isDefined(var2)) {}

  if(!scripts\engine\utility::array_contains(level.loot.offhands, var2)) {
    return 0;
  }

  var3 = distancesquared(var1, level.player.origin);

  if(var3 > 2250000) {
    return 0;
  }

  var4 = getoffhandprobabilityfromname(var0);

  if(isDefined(var4)) {}

  var5 = 0;

  if(scripts\engine\sp\utility::player_has_equipment(var2)) {
    var5 = level.player getweaponammostock(var2);
  }

  var6 = weaponmaxammo(var2);

  if(var5 >= var6) {
    var7 = 0;
  } else {
    var7 = var5 * (1 - var6 / var7);
  }

  if(randomint(100) > var7) {
    return 0;
  }

  var8 = 0;

  foreach(var10 in level.loot.items) {
    if(scripts\engine\utility::is_equal(var10.name, var1) && !itemworldplaced(var10)) {
      var8++;
    }
  }

  var12 = var8 + var6 >= var7;

  if(!var12) {
    return 1;
  }

  if(trylootdespawn(var1)) {
    return 1;
  }

  return 0;
}

function waittillplayercanloot() {
  while(level.player ismeleeing()) {
    waitframe();
  }
}

function playlootsound(var0) {
  level.loot.sfx scripts\engine\utility::delaycall(0.2, &playsound, level.loot.types[var0].sound);
}

function createnotification(var0, var1) {
  var2 = undefined;
  var3 = 600;
  var4 = 300;

  for(var5 = 0; var5 < level.loot.notifications.size; var5++) {
    if(level.loot.notifications[var5].locname == var1) {
      var2 = level.loot.notifications[var5];
      var2 notify("stop_fading");
      var4 = var2.icon.y;
    }
  }

  var6 = 224;
  var7 = 432;
  var8 = newhudelem();
  var8.x = var6;
  var8.y = var7;
  var8.alignx = "right";
  var8.aligny = "top";
  var8.sort = 2;
  var8.alpha = 0;
  var8 setshader(var0, 22, 22);
  var8.shader = var0;
  var9 = newhudelem();
  var9.x = var6;
  var9.y = var7 + 5;
  var9.alignx = "left";
  var9.aligny = "top";
  var9.font = "hudsmall";
  var9.fontscale = 0.75;
  var9.alpha = 0;
  var9 settext(var1);
  var8 fadeovertime(0.15);
  var8 moveovertime(0.215);
  var8.alpha = 0.8;
  var8.x = var3;
  var8.y = var4;
  var9 fadeovertime(0.15);
  var9 moveovertime(0.215);
  var9.alpha = 1;
  var9.x = var3;
  var9.y = var4 + 5;
  var10 = spawnStruct();
  var10.icon = var8;
  var10.text = var9;
  var10.locname = var1;

  if(!isDefined(var2)) {
    level.loot.notifications[level.loot.notifications.size] = var10;
  }

  level.player scripts\engine\utility::waittill_notify_or_timeout("death", 0.215);

  if(isDefined(var2)) {
    thread notificationdisplayandfade(var2, var0);
    wait 0.05;
    destroylootnotification(var10);
    return;
  }

  foreach(var12 in level.loot.notifications) {
    var12.icon.y -= 22;
    var12.text.y -= 22;
  }

  thread notificationdisplayandfade(var10, var0);
}

function notificationdisplayandfade(var0, var1) {
  var0 notify("reset");
  var0 endon("death");
  var0 endon("stop_fading");
  var0 endon("reset");
  thread notificationpulse();
  var0.icon.alpha = 0.8;
  var0.text.alpha = 1;

  if(isalive(level.player)) {
    level.player scripts\engine\utility::waittill_notify_or_timeout("death", 3);
  } else {
    destroylootnotification(var0);
    return;
  }

  var0.icon.alpha = 0.8;
  var0.text.alpha = 1;
  var2 = gettime() + 500;

  while(isalive(level.player) && gettime() < var2) {
    wait 0.05;
    var0.icon.alpha -= 0.1;
    var0.text.alpha -= 0.1;
  }

  destroylootnotification(var0);
}

function notificationpulse() {
  var0 = 2;
  self.icon scaleovertime(0.05, 30, 30);
  self.icon moveovertime(0.05);
  self.icon.y -= var0;
  self.icon.x += var0;
  wait 0.05;

  if(isDefined(self) && isDefined(self.icon)) {
    self.icon scaleovertime(0.15, 22, 22);
    self.icon moveovertime(0.15);
    self.icon.y += var0;
    self.icon.x -= var0;
    return;
  }
}

function waittillnextloottime() {
  var0 = gettime();
  var1 = level.loot.lastloottime + 250;

  if(var0 > var1) {
    level.loot.lastloottime = var0;
    return;
  }

  level.loot.lastloottime = var1;

  while(gettime() < var1) {
    waitframe();
  }
}

function destroylootnotification() {
  if(scripts\engine\utility::array_contains(level.loot.notifications, self)) {
    level.loot.notifications = scripts\engine\utility::array_remove(level.loot.notifications, self);
  }

  self.icon destroy();
  self.text destroy();
  self.name = undefined;
  self notify("death");
}

function setworldloot() {
  waittillframeend();

  foreach(var1 in scripts\engine\utility::getStructArray("lootSpawn", "targetname")) {
    if(!isrefloot()) {
      spawnlootitem(var1.script_noteworthy, var1.origin, var1.angles, 0, 1);
    }
  }
}

function isrefloot() {
  if(isDefined(self.spawnflags) && self.spawnflags & 1) {
    return 1;
  }

  return 0;
}

function createpickupicon(var0) {
  self endon("death");
  self endon("entitydeleted");

  while(distancesquared(level.player.origin, self.origin) > 2250000) {
    waitframe();
  }

  target_alloc(self, (0, 0, 10));
  target_drawsquare(self);
  target_drawsingle(self);
  target_setcolor(self, (1, 1, 1), 0);
  target_setscaledrendermode(self, 0);
  target_showtoplayer(self, level.player);
  target_setshader(self, var0);
  target_flush(self);
  GscBinSkip4(0x35);
}

function updatepickupicon() {
  self.alpha = 0;
  self.iconsize = 0;
  var0 = gettime();

  for(;;) {
    var1 = distance(level.player.origin, self.origin);
    var2 = gettime() < var0 + 2150;
    var3 = isalive(level.player) && level.player scripts\engine\trace::can_see_origin(self.origin + (0, 0, 10), 0);

    if(var2 || var3) {
      var4 = 1 - scripts\engine\math::normalize_value(0, 1000, var1);
      var5 = var4 * 1.25;
    } else {
      var5 = 0;
    }

    if(var5 != self.alpha) {
      var6 = clamp((var5 - self.alpha) * 0.45, -0.125, 0.125);
      var7 = self.alpha + var6;
      target_setcolor(self, (1, 1, 1), var7);
      self.alpha = var7;
    }

    var8 = scripts\engine\math::normalize_value(100, 1000, var1);
    var9 = int(scripts\engine\math::factor_value(32, 8, var8) * 1);

    if(var9 != self.iconsize) {
      target_setminsize(self, var9, 0);
      target_setmaxsize(self, var9, 0);
      self.iconsize = var9;
    }

    waitframe();
  }
}

function indonotspawnlootvolume(var0) {
  var1 = getEntArray("doNotSpawnLoot", "targetname");

  foreach(var3 in var1) {
    if(var0 istouching(var3)) {
      return true;
    }
  }

  return false;
}

function set_force_armor_drop(var0) {
  self.lootforcearmordrop = var0;
}

function force_armor_drop() {
  return istrue(self.lootforcearmordrop);
}