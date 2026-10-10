/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_38db8bccc9eb301f.gsc
*************************************************/

#using script_1feb0785278dafea;
#using script_2f988b639fd733;
#using script_3e01f6b89a26a5d9;
#using script_4bb70b1c5860caaa;
#using script_6e65833db7358163;
#using script_77cef444e824c23;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\supers;
#using scripts\mp\utility\spawn_event_aggregator;
#namespace field_upgrades;

function init() {
  function_6e7290c8ee4f558b("<dev string:x1c>");
  add_devgui_command("<dev string:x35>", "<dev string:x43>");
  function_b23a59dfb4ca49a1("<dev string:x67>", "<dev string:x83>", &function_a3bc0cc17a8becc7);
  function_b23a59dfb4ca49a1("<dev string:x9f>", "<dev string:xbb>", &function_a3bc0cc17a8becc7);
  function_b23a59dfb4ca49a1("<dev string:xd7>", "<dev string:xf3>", &function_a3bc0cc17a8becc7);
  function_b23a59dfb4ca49a1("<dev string:x10f>", "<dev string:x12b>", &function_a3bc0cc17a8becc7);
  function_b23a59dfb4ca49a1("<dev string:x147>", "<dev string:x163>", &function_a3bc0cc17a8becc7);
  function_b23a59dfb4ca49a1("<dev string:x17f>", "<dev string:x19b>", &function_a3bc0cc17a8becc7);
  function_fe953f000498048f();

  level.var_762c63041675c851 = &function_f29f48692125dbe5;
  level.onplayerspawncallbacks = default_to(level.onplayerspawncallbacks, []);
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&function_549fe53b0dbd8eb9);
  level.var_f04301db8ca5ecfa = [];
}

function function_549fe53b0dbd8eb9() {
  self.pausesuperpointsovertime = 1;
}

function function_e7b6474ebd683537(var_9086f8d586abcdc2, var_bf8ab5d3f72923a8) {
  var_5fd8138e5546872f = getscriptbundle(level.supertable);

  foreach(var_ed9ff549fe979ee0 in var_5fd8138e5546872f.super_list) {
    var_9ab60dae428d6472 = var_ed9ff549fe979ee0.ref;
    var_dd792c8e55182d7d = var_ed9ff549fe979ee0.bundle;

    if(isDefined(var_9ab60dae428d6472) && isDefined(var_dd792c8e55182d7d) && var_9ab60dae428d6472 == var_9086f8d586abcdc2) {
      return getscriptbundlefieldvalue("super:" + var_dd792c8e55182d7d, var_bf8ab5d3f72923a8);
    }
  }
}

function function_f29f48692125dbe5() {
  foreach(var_e9a02c6cae8ee1d8 in level.superglobals.supersbyid) {
    switch (var_e9a02c6cae8ee1d8) {
      case #"hash_d508880fd30faf68":
        namespace_6ac5b64d7fe68733::init();
        break;
      case #"hash_96f27034a876b211":
        namespace_f585f5e438cbdbc8::init();
        break;
      case #"hash_95aa0913ab7d91a0":
        namespace_36cac461fc37e847::init();
        break;
      case #"hash_25d6c8e468976601":
        namespace_f375801da2a1ee3a::init();
        break;
      case #"hash_aa20722d2fc8768c":
        namespace_1eba3ff32243c3bd::init();
        break;
      case #"hash_62554bb1c5b6193e":
        namespace_771aa7cc1ddd631::init();
        break;
    }
  }
}

function function_6e6915563d108662(eventstring, victim, sweapon) {
  player = self;

  if(isPlayer(player)) {
    s_super = player scripts\mp\supers::getcurrentsuper();

    if(isDefined(s_super) && !istrue(s_super.isinuse)) {
      var_611cd79750d56d20 = s_super.basepoints;
      player scripts\mp\supers::givesuperpoints(0, eventstring);
      var_16b01848ed89eab7 = s_super.basepoints - var_611cd79750d56d20;

      iprintlnbold("<dev string:x1b7>" + s_super.basepoints + "<dev string:x1db>" + s_super.staticdata.pointsneeded);

      return var_16b01848ed89eab7;
    }
  }

  return 0;
}

function function_dabbdf1761a23f5c() {
  s_super = scripts\mp\supers::getcurrentsuper();
  var_6344aa9df2107f06 = default_to(s_super.staticdata.var_6344aa9df2107f06, 0);
  return var_6344aa9df2107f06;
}

function function_ed72d0f08d00c1c0() {
  super = scripts\mp\supers::getcurrentsuper();
  bundle = super.staticdata.bundle;
  return bundle;
}

function function_75abcff430ed00b7(weapon_name) {
  self endon("death");
  gestureweapon = makeweapon(weapon_name);
  firetime = gestureweapon.firetime;

  if(!function_2f2713099cb7dd02(weapon_name)) {
    self giveandfireoffhand(gestureweapon);
  }

  wait firetime;
  self playRumbleOnEntity("zombie_field_upgrade_wand_fire");
  params = spawnStruct();
  params.weaponname = weapon_name;
  callback::callback("field_upgrade_used", params);
  return true;
}

function function_2f2713099cb7dd02(weapon_name) {
  switch (weapon_name) {
    case #"hash_2d5e3aea120977e4":
    case #"hash_ad7d698f8bbcd28b":
    case #"hash_b4aacb18bf56174e":
    case #"hash_ba0c9cf2eb888883":
    case #"hash_c69521daa24c2ec0":
    case #"hash_e9f42c97ae3fa950":
      return 1;
    default:
      return 0;
  }
}

function function_a3bc0cc17a8becc7(a_params) {
  foreach(player in level.players) {
    s_super = player scripts\mp\supers::getcurrentsuper();

    if(isDefined(s_super)) {
      s_super.staticdata.var_6344aa9df2107f06 = int(a_params[0]);
      iprintlnbold("<dev string:x1e0>" + s_super.staticdata.var_6344aa9df2107f06);
    }
  }
}

# /