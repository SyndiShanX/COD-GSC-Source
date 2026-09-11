/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\little_bird_mp.gsc
**************************************************/

function little_bird_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("little_bird", "spawnCallback", &little_bird_mp_spawncallback);
  little_bird_mp_initspawning();
  zombiedropstags();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("little_bird", &scripts\cp_mp\vehicles\little_bird::little_bird_explode);

  if(istrue(level.ref_13375)) {
    scripts\cp_mp\utility\script_utility::registersharedfunc("little_bird", "endEnterInternal", &zombie);
    return;
  }
}

function little_bird_mp_initspawning() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("little_bird", 1);
  var0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
  var0.areplayersnear = 60;

  if(scripts\mp\utility\game::getgametype() == "arm") {
    var0.ref_12ca1 = 30;
    return;
  }
}

function zombiedropstags() {
  var0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("little_bird", 1);
  var0.frontextents = 78;
  var0.backextents = 28;
  var0.leftextents = 55;
  var0.rightextents = 55;
  var0.bottomextents = -80;
  var0.distancetobottom = 80;
  var0.loscheckoffset = (0, 0, -70);
}

function little_bird_mp_spawncallback(var0, var1) {
  var2 = scripts\cp_mp\vehicles\little_bird::little_bird_create(var0, var1);

  if(isDefined(var2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &little_bird_mp_ondeathrespawncallback;
  }

  return var2;
}

function little_bird_mp_ondeathrespawncallback() {
  thread little_bird_mp_waitandspawn();
}

function little_bird_mp_waitandspawn() {
  var0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var0, var1);
  var1.ref = var0.ref;
  var1.rallypointhealth = var0.rallypointhealth;
  var2 = spawnStruct();
  var3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421c("little_bird", var1, var2);

  if(isDefined(var3)) {
    if(isDefined(var1.ref) && istrue(level.userallypointvehicles) && level.userallypointvehicles != 2) {
      var3.ref = var1.ref;
      var3.maxhealth = int(max(var3.maxhealth, var1.rallypointhealth));
      var3.health = var3.maxhealth;
      scripts\mp\rally_point::rallypointvehicle_activate(var3);
    }

    if(istrue(level.ref_13375)) {
      scripts\mp\gametypes\arm::ref_1413a(var3, var3.team);
      return;
    }

    return;
  }
}

function zombie(var0, var1, var2, var3, var4) {
  if(istrue(level.ref_13375)) {
    var0 scripts\mp\gametypes\arm::ref_141ff(var3.team);
    return;
  }
}