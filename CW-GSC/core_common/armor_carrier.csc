/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\armor_carrier.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\system_shared;
#namespace armor_carrier;

function private autoexec __init__system__() {
  system::register(#"armor_carrier", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register_clientuimodel("hudItems.armorPlateCount", #"hud_items", #"armorplatecount", 1, 4, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("hudItems.armorPlateMaxCarry", #"hud_items", #"armorplatemaxcarry", 1, 4, "int", undefined, 0, 0);
  level.var_a05cd64e = &function_a05cd64e;
  level.var_8ef8b9e8 = getweapon(#"armor_plate");
  callback::on_localclient_connect(&on_localclient_connect);
  callback::on_localplayer_spawned(&on_localplayer_spawned);
  serverfield::register("armor_plate_behavior", 1, 1, "int");

  if(getDvar(#"g_gametype") === "<dev string:x38>") {
    level.var_a2ef9587 = 1;
  }
}

function private on_localclient_connect(localclientnum) {
  function_321bb79b(localclientnum);
}

function private on_localplayer_spawned(localclientnum) {
  function_321bb79b(localclientnum);
}

function private function_321bb79b(localclientnum, value) {
  player = function_27673a7(localclientnum);

  if(!isDefined(player)) {
    return;
  }

  if(!isDefined(value)) {
    setting = gamepadusedlast(localclientnum) ? # "armor_plate_behavior_gpad" : # "armor_plate_behavior_kbm";
    value = isDefined(function_ab88dbd2(localclientnum, setting)) ? function_ab88dbd2(localclientnum, setting) : 0;
  }

  if(player.armor_plate_behavior !== value) {
    player serverfield::set("armor_plate_behavior", value);
    player.armor_plate_behavior = value;
  }
}

function private function_a05cd64e(localclientnum) {
  if(!self function_da43934d()) {
    return;
  }

  if(self function_86b9a404()) {
    function_321bb79b(localclientnum);
    switchtoweapon(localclientnum, level.var_8ef8b9e8);
    return 1;
  }

  return 0;
}

function private function_86b9a404() {
  if(!isPlayer(self) || self isplayerdead()) {
    function_ad64a47("<dev string:x50>");

    return false;
  }

  localclientnum = self getlocalclientnumber();

  if(!isDefined(localclientnum)) {
    function_ad64a47("<dev string:x6f>");

    return false;
  }

  currentweapon = getcurrentweapon(localclientnum);

  if(currentweapon === level.var_8ef8b9e8 || currentweapon === level.weaponnone) {
    function_ad64a47("<dev string:x8e>");

    return false;
  }

  if(isonturret(localclientnum) || self function_94ba7a2e() || self function_9a0edd92() || self isinfreefall() || self inlaststand() || self isskydiving()) {
    function_ad64a47("<dev string:xb6>");

    return false;
  }

  if(isDefined(getplayervehicle(self))) {
    if(currentweapon === level.weaponnone || function_3feb54c8(localclientnum)) {
      function_ad64a47("<dev string:x11c>");

      return false;
    }
  }

  var_6aae821e = hasweapon(localclientnum, level.var_8ef8b9e8);
  currentcount = self clientfield::get_player_uimodel("hudItems.armorPlateCount");
  currentarmor = self getplayerarmor();

  if(!var_6aae821e) {
    function_ad64a47("<dev string:x15e>");
  }

  if(currentcount <= 0) {
    function_ad64a47("<dev string:x183>");
  }

  if(currentarmor >= 225) {
    function_ad64a47("<dev string:x19b>");
  }

  return currentcount > 0 && currentarmor < 225 && var_6aae821e;
}

function event_handler[event_647adea6] function_465c8646(eventstruct) {
  if(eventstruct.name === # "armor_plate_behavior_gpad" || eventstruct.name === # "armor_plate_behavior_kbm") {
    function_321bb79b(eventstruct.localclientnum, int(eventstruct.value));
  }
}

function function_ad64a47(reasonstring) {
  if(level.var_a2ef9587 === 1) {
    println("<dev string:x1b5>" + reasonstring);
  }
}