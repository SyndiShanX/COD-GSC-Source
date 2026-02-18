/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4d748e58ce25b60c.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_179d92c110788f71;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ce46999727f2f2b;
#using script_1d730eca5a7f1fa8;
#using script_1ee011cd0961afd7;
#using script_2474a362752098d2;
#using script_2a5bf5b4a00cee0d;
#using script_350cffecd05ef6cf;
#using script_3bbf85ab4cb9f3c2;
#using script_40f967ad5d18ea74;
#using script_4611af4073d18808;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_68cdf0ca5df5e;
#using script_6b6510e124bad778;
#using script_74a56359b7d02ab6;
#using script_774302f762d76254;
#using script_f38dc50f0e82277;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weapons;
#namespace doa_player;

function init() {
  clientfield::register("allplayers", "bombDrop", 1, 1, "int");
  clientfield::register("toplayer", "cutscene", 1, 2, "int");
  clientfield::register("toplayer", "controlBinding", 1, 4, "counter");
  clientfield::register("toplayer", "goFPS", 1, 1, "counter");
  clientfield::register("toplayer", "exitFPS", 1, 1, "counter");
  clientfield::register("world", "doafps", 1, 1, "int");
  clientfield::register("toplayer", "changeCamera", 1, 1, "counter");
  clientfield::register("toplayer", "resetCamera", 1, 1, "counter");
  clientfield::register("toplayer", "hardResetCamera", 1, 1, "counter");
  clientfield::register("toplayer", "lastStand", 1, 2, "int");
  clientfield::register("toplayer", "setCameraDown", 1, 5, "int");
  clientfield::register("toplayer", "setCameraSide", 1, 2, "int");
  clientfield::register("toplayer", "showMap", 1, 1, "int");
  clientfield::register("toplayer", "toggleflashlight", 1, 1, "int");
  clientfield::register("allplayers", "flipCamera", 1, 2, "int");
  serverfield::register("lstick_input_inc", 1, 2, "int", &function_98958f23);
  serverfield::register("rstick_input_inc", 1, 2, "int", &function_5375ff3b);
  level.var_73ffa220 = [];
  level.laststandweapon = getweapon(#"downed_doa");
  level.doa.var_e09e5160 = 0;
  callback::on_connect(&on_player_connect);
  callback::on_spawned(&on_player_spawned);
  callback::on_disconnect(&on_player_disconnect);
  callback::add_callback(#"on_host_migration_begin", &on_host_migration_begin);
  callback::add_callback(#"on_host_migration_end", &on_host_migration_end);

  if(isDefined(level.doa.var_cf250523)) {
    level.callbackplayerkilled = level.doa.var_cf250523;
  }

  if(isDefined(level.doa.var_abe40be4)) {
    level.callbackplayerdamage = level.doa.var_abe40be4;
  }

  if(isDefined(level.doa.var_cd10d20a)) {
    level.callbackplayerlaststand = level.doa.var_cd10d20a;
  }
}

function function_5375ff3b(oldval, newval) {
  if(!isPlayer(self) || !isDefined(self.doa)) {
    return;
  }

  if(!isDefined(self.doa.var_7f8d38c2)) {
    self.doa.var_7f8d38c2 = 0;
  }

  if(newval > 0) {
    self.doa.var_7f8d38c2++;
    return;
  }

  self.doa.var_7f8d38c2 = 0;
}

function function_98958f23(oldval, newval) {
  if(!isPlayer(self) || !isDefined(self.doa)) {
    return;
  }

  if(!isDefined(self.doa.var_43c43abc)) {
    self.doa.var_43c43abc = 0;
  }

  if(newval > 0) {
    self.doa.var_43c43abc++;
    return;
  }

  self.doa.var_43c43abc = 0;
}

function private on_host_migration_begin(params) {
  if(isPlayer(self)) {
    self notify(#"hash_279998c5df86c04d");
    self notify(#"hash_7893364bd228d63e");
  }
}

function private on_host_migration_end(params) {
  if(isPlayer(self)) {
    self thread namespace_7f5aeb59::turnplayershieldon();
    self clientfield::increment_to_player("controlBinding");
  }
}

function function_591138a4() {
  self notify("1577d7ba2bd6dee5");
  self endon("1577d7ba2bd6dee5");
  self endon(#"disconnect");

  while(true) {
    waitresult = self waittill(#"menuresponse");

    if(getplayers().size == 1) {
      continue;
    }

    if(!isDefined(waitresult.menu)) {
      continue;
    }

    if(!isDefined(waitresult.response)) {
      continue;
    }

    if(waitresult.menu == # "startmenu_main") {
      if(waitresult.response == # "menu_opened") {
        continue;
      }

      if(waitresult.response == # "menu_closed") {}
    }
  }
}

function function_2858dd5a() {
  self endon(#"disconnect");
  self freezecontrols(1);
  self.ignoreme = 1;

  while(!isDefined(self.doa)) {
    waitframe(1);
  }

  self namespace_83eb6304::function_3ecfde67("remote_player_busy");

  printtoprightln("<dev string:x38>" + gettime() + "<dev string:x3d>" + self getentitynumber(), (1, 1, 1));

  self lui::screen_fade_out(0);
  self namespace_ec06fe4a::freezeplayercontrols(1);

  while(!is_true(self.var_736d81ba) || self isloadingcinematicplaying()) {
    waitframe(1);
  }

  self.var_90b81208 = level.doa.roundnumber;
  self.var_248bd83 = level.doa.roundnumber;
  var_9a24b67c = level.var_73ffa220[self.name];

  if(isDefined(var_9a24b67c)) {
    if(!isDefined(self.doa.var_87c1cd32)) {
      self.doa.var_87c1cd32 = 0;
    }

    self.var_248bd83 = var_9a24b67c.roundnumber;
    self.doa.var_87c1cd32 = var_9a24b67c.var_87c1cd32;
    self thread namespace_1c2a96f9::function_edfc9233(var_9a24b67c.var_484cc88b);

    if(isDefined(var_9a24b67c.lastscore) && var_9a24b67c.lastscore > self.doa.score.var_1397c196) {
      self.doa.score.var_1397c196 = var_9a24b67c.lastscore;
      self.doa.score.points = var_9a24b67c.lastscore;
      self.doa.score.var_5eac81d0 = var_9a24b67c.var_e239d6ea;
    }

    if(isDefined(var_9a24b67c.var_5229d36f) && var_9a24b67c.var_5229d36f > self.doa.score.var_a928c52e) {
      self.doa.score.var_a928c52e = var_9a24b67c.var_5229d36f;
    }
  }

  var_46460109 = {
    #roundnumber: self.var_248bd83, #var_484cc88b: self.doa.var_484cc88b, #var_87c1cd32: self.doa.var_87c1cd32, #lastscore: self.doa.score.var_1397c196, #var_5229d36f: self.doa.score.var_a928c52e, #var_e239d6ea: self.doa.score.var_5eac81d0
  };
  level.var_73ffa220[self.name] = var_46460109;

  if(isDefined(level.var_9dab87f7)) {
    self function_fc61ee02();
    self thread namespace_7f5aeb59::turnplayershieldon(0);
  }

  self clientfield::set_player_uimodel("closeLoadingMovie", 1);

  if(!isDefined(level.doa.var_ecff3871)) {
    level.doa.var_ecff3871 = 0;
  }

  self function_a48eea2b(level.doa.var_ecff3871);
  self.is_ready = 1;
  self.ignoreme = 0;
  level.var_3fd55ae0++;
  util::wait_network_frame();
  self namespace_83eb6304::turnofffx("remote_player_busy");
  self thread function_cf969eb1();
}

function function_cf969eb1(timeout = 5) {
  self endon(#"disconnect");

  while(timeout > 0 || !self isstreamerready(-1, 1)) {
    if(isDefined(self.var_d57eeb7f) && self.var_d57eeb7f == 0) {
      self namespace_83eb6304::turnofffx("remote_player_busy");
      return;
    }

    wait 0.1;
    timeout -= 0.1;
  }

  self namespace_83eb6304::turnofffx("remote_player_busy");

  if(isDefined(self.var_d57eeb7f) && self.var_d57eeb7f > 0) {
    self thread namespace_7f5aeb59::function_96c20925(3);
  }

  self.var_c2fe0818 = 1;

  if(!isDefined(level.var_9dab87f7) && getplayers().size > 1 && level.var_3fd55ae0 != level.var_5c6783e9) {
    level doa_banner::function_7a0e5387(50);
    level.var_65efe052 = 1;
  }
}

function on_player_connect() {
  self.var_f5602976 = gettime();
  self setclientminiscoreboardhide(1);
  self thread function_2858dd5a();
  self thread function_591138a4();
}

function on_player_spawned() {
  self endon(#"disconnect");
  self namespace_7f5aeb59::function_f3143608();

  if(isDefined(level.doa.var_16a35e94)) {
    self thread[[level.doa.var_16a35e94]]();
  }

  if(isDefined(level.doa.var_4e554b79)) {
    spot = [[level.doa.var_4e554b79]](self.entnum);

    if(isDefined(spot)) {
      self setorigin(spot.origin);
      self setplayerangles(spot.angles);
    }
  }

  self thread function_eef0e695();
  self notify(#"stop_player_monitor_travel_dist");
  self.var_736d81ba = 1;
}

function function_fc61ee02() {
  self endon(#"disconnect");

  if(level.doa.roundnumber > 4) {
    self.doa.score.lives = 0;
    self.doa.score.bombs = 0;
    self.doa.score.boosts = 1;
  }

  if(isbot(self)) {
    return;
  }

  self.var_fcb4914a = 1;
  setloc = 0;

  if(isDefined(level.doa.var_182fb75a)) {
    spot = level.doa.var_187ed224;

    if(isDefined(spot)) {
      self setorigin(spot.origin);
      self setplayerangles(spot.angles);
      setloc = 1;
    }
  } else if(isDefined(level.doa.var_a77e6349)) {
    spot = [[level.doa.var_a77e6349]] - > function_5dfb6d67()[0];

    if(isDefined(spot)) {
      self setorigin(spot.origin);
      self setplayerangles(spot.angles);
      setloc = 1;
    }
  } else {
    assert(level.doa.world_state == 0, "<dev string:x5c>");

    while(!isDefined(level.doa.var_39e3fa99)) {
      waitframe(1);
    }

    spot = [[level.doa.var_39e3fa99]] - > function_fc81ec00(self getentitynumber());
    self function_a48eea2b(level.doa.var_ecff3871);

    if(isDefined(spot)) {
      self setorigin(spot.origin);
      self setplayerangles(spot.angles);
      setloc = 1;
    }
  }

  if(!is_true(setloc)) {
    players = getplayers();

    foreach(player in players) {
      if(player == self) {
        continue;
      }

      self setorigin(player.origin + (randomint(10), randomint(10), 4));
      self setplayerangles(player.angles);
      break;
    }
  }

  wait 1;

  if(level.doa.world_state === 0) {
    self function_a48eea2b(level.doa.var_ecff3871);
  }

  self thread namespace_7f5aeb59::function_96c20925();
  self.var_fcb4914a = undefined;
  self clientfield::increment_to_player("setCompassVis");
}

function function_eef0e695() {
  self notify("375986b248ec62b2");
  self endon("375986b248ec62b2");
  self endon(#"disconnect");
  self thread namespace_7f5aeb59::function_d690f109();
  wait 10;
  self thread namespace_7f5aeb59::function_d690f109();
  wait 10;
  self thread namespace_7f5aeb59::function_d690f109();
}

function on_player_disconnect() {
  self.disconnecting = 1;
  self namespace_d2efac9a::function_bd2f140c();
  self namespace_d2efac9a::commitstats();

  if(isDefined(self.doa.score.var_d252ca7f)) {
    level clientfield::set_world_uimodel(self.doa.score.var_d252ca7f, 0);
  }

  if(isDefined(self.doa)) {
    self.doa.var_e46a9e57 = undefined;
    self.doa.score = undefined;
    self.doa = undefined;
  }
}

function main() {
  level endon(#"game_over");
  level waittill(#"hash_671684f03a58b3a3");

  foreach(player in namespace_7f5aeb59::function_23e1f90f()) {
    player namespace_7f5aeb59::function_513831e1(1);
    player clientfield::increment_to_player("controlBinding");
    player clientfield::increment_to_player("hardResetCamera");
    player namespace_eccff4fb::resetplayer();
  }

  while(true) {
    waitframe(1);
    players = getplayers();
    curcount = players.size;

    if(curcount != level.doa.var_e09e5160) {
      namespace_1e25ad94::debugmsg("<dev string:x8c>" + curcount);
    }

    level.doa.var_e09e5160 = curcount;
    aliveplayers = 0;
    timecurrent = gettime();

    foreach(player in players) {
      if(!namespace_7f5aeb59::isplayervalid(player)) {
        continue;
      }

      if(!is_true(player.laststand) || player.doa.score.lives > 0 || is_true(player.var_4a81243b)) {
        aliveplayers++;
      }

      player namespace_6e90e490::updatehud();
      player namespace_eccff4fb::function_7752515d();
      player namespace_41cb996::updateweapon();

      if(player.birthtime + 500 > timecurrent) {
        continue;
      }

      if(!is_true(player.laststand)) {
        player function_7310b24f();
        player namespace_dfc652ee::function_d936944a();
        player namespace_dfc652ee::function_cbae9ca3();
      }
    }

    if(aliveplayers == 0) {
      if(isDefined(level.doa.var_abd5eb1e)) {
        [[level.doa.var_abd5eb1e]]();
      }
    }
  }
}

function function_7310b24f() {
  profilestart();

  if(isDefined(level.var_ec5aa760)) {
    self[[level.var_ec5aa760]]();
  }

  if(self hasdobj() == 0) {
    profilestop();
    return;
  }

  self function_a8cdc084();

  if(is_true(self.doa.var_a5eb0385)) {
    profilestop();
    return;
  }

  self function_ba8327d7();
  self function_56544e8b();
  self function_cf940b05();
  self function_74ba13d0();
  self function_902013ca();
  self function_23c07f29();
  self function_ffc15733();
  profilestop();
}

function function_ffc15733() {
  if(!isDefined(self.doa)) {
    return;
  }

  if(is_true(self.doa.var_42bbe20)) {
    return;
  }

  if(isDefined(level.doa.var_a77e6349)) {
    if(!is_true(self.doa.var_381a0f4e)) {
      if(self actionslotfourbuttonPressed() || self buttonbitstate("BUTTON_BIT_CAMERA_SIDE")) {
        self.doa.var_381a0f4e = 1;
      }
    }

    if(isDefined(self.tweakcam) || is_true(self.doa.var_af150b2c) || is_true(level.doa.var_a3e53b88) || is_true(level.doa.var_af74d0b)) {
      self.doa.var_381a0f4e = 0;
    }

    if(is_true(self.doa.var_381a0f4e)) {
      if(!self actionslotfourbuttonPressed() && !self buttonbitstate("BUTTON_BIT_CAMERA_SIDE")) {
        self thread function_a48eea2b(!self.doa.camera_yaw);
        self.doa.var_381a0f4e = 0;
      }
    }
  }
}

function function_a48eea2b(yaw = 0, reset = 0) {
  self endon(#"disconnect");
  assert(isPlayer(self));
  assert(yaw == 0 || yaw == 1);

  if(!isDefined(self) || !isDefined(self.doa)) {
    return;
  }

  self.doa.var_42bbe20 = 1;

  if(reset) {
    self clientfield::set("flipCamera", 2);
    self function_9aabf044(0);
    self.doa.camera_yaw = 0;
  } else if(yaw == 0) {
    self.doa.camera_yaw = yaw;
    self function_9aabf044(0);
    self clientfield::set("flipCamera", 0);
  } else if(yaw == 1) {
    self.doa.camera_yaw = yaw;
    self function_9aabf044(1);
    self clientfield::set("flipCamera", 1);
  }

  util::wait_network_frame();
  self.doa.var_42bbe20 = undefined;
}

function function_a8cdc084() {
  if(!isDefined(self.doa)) {
    return;
  }

  if(is_true(level.doa.var_a3e53b88) || (self actionslottwobuttonPressed() || self buttonbitstate("BUTTON_BIT_MAP")) && !is_true(self.doa.var_9ca03c2f)) {
    self clientfield::set_to_player("showMap", 1);
    self.doa.var_9ca03c2f = 1;
  }

  if(!is_true(level.doa.var_a3e53b88) && !self actionslottwobuttonPressed() && !self buttonbitstate("BUTTON_BIT_MAP")) {
    self clientfield::set_to_player("showMap", 0);
    self.doa.var_9ca03c2f = 0;
  }
}

function function_23c07f29() {
  if(!isDefined(self.doa) || !is_true(self.doa.var_82fb5d17)) {
    return;
  }

  if(is_true(self.doa.var_11cd9fd3)) {
    if(self actionslotthreebuttonPressed() || self buttonbitstate("BUTTON_BIT_FLASHLIGHT")) {
      return;
    }

    self.doa.var_11cd9fd3 = undefined;
  }

  if(self actionslotthreebuttonPressed() || self buttonbitstate("BUTTON_BIT_FLASHLIGHT")) {
    self.doa.var_11cd9fd3 = 1;
    self.doa.var_56fdd2fe = 1;
    return;
  }

  if(is_true(self.doa.var_56fdd2fe)) {
    self.doa.var_f583234e = !self.doa.var_f583234e;
    self clientfield::set_to_player("toggleflashlight", self.doa.var_f583234e);
  }

  self.doa.var_56fdd2fe = 0;
}

function function_8f915b47(a, b) {
  return a.doa.score.lives > b.doa.score.lives;
}

function function_902013ca() {
  time = gettime();

  if(!isDefined(self.doa) || time < self.doa.var_99c6ee47) {
    return;
  }

  if(is_true(self.doa.var_a8d9dfbe)) {
    if(self actionslotonebuttonPressed() || self buttonbitstate("BUTTON_BIT_DONATE_LIFE")) {
      return;
    }

    self.doa.var_a8d9dfbe = undefined;
  }

  var_7ea80475 = 0;

  if(level.doa.var_6c58d51 > 0 && level.doa.var_a4af7793.size && self.doa.score.lives > 2 && level flag::get("doa_round_spawning")) {
    if(time > self.doa.var_d1d5998d) {
      self.doa.var_d1d5998d = time + 1500;
      var_851aa222 = namespace_7f5aeb59::function_518c4c78();

      if(var_851aa222.size) {
        var_9781a37d = array::quick_sort(var_851aa222, &function_8f915b47);

        foreach(player in var_9781a37d) {
          if(time < player.doa.var_2c18f1d5) {
            continue;
          }

          if(player.doa.score.lives <= 2) {
            continue;
          }

          if(player == self) {
            var_7ea80475 = 1;
            break;
          }
        }
      }
    }
  }

  if(self actionslotonebuttonPressed() || self buttonbitstate("BUTTON_BIT_DONATE_LIFE")) {
    self.doa.var_a8d9dfbe = 1;
    self.doa.var_f8fd8e97 = 1;
    return;
  }

  if(self.doa.score.lives >= 1 && (is_true(self.doa.var_f8fd8e97) || var_7ea80475)) {
    players = arraysortclosest(level.doa.var_a4af7793, self.origin);

    foreach(player in players) {
      if(self === player) {
        continue;
      }

      if(is_true(player.doa.var_7731eb4f)) {
        continue;
      }

      if(var_7ea80475 && player.doa.var_22e62f63 - player.doa.var_ac8a92d4 < 1500) {
        continue;
      }

      self.doa.var_2c18f1d5 = time + 2 * 60000;
      self.doa.var_99c6ee47 = gettime() + 2000;
      self thread givealifetoplayer(player, var_7ea80475);
      break;
    }
  }

  self.doa.var_f8fd8e97 = 0;
}

function givealifetoplayer(target, forced = 0) {
  if(self.doa.score.lives > 0) {
    if(isDefined(target)) {
      target.doa.var_7731eb4f = 1;
    }

    self.doa.score.lives--;
    self namespace_e32bb68::function_3a59ec34("hallelujah");
    self thread function_cdcf0e57(forced ? 100 : 120);
    self thread namespace_7f5aeb59::turnplayershieldon();
    model = namespace_ec06fe4a::spawnmodel(self.origin, "zombietron_extra_life", self.angles, "giveALifeToPlayer");

    if(isDefined(model)) {
      model thread namespace_83eb6304::function_3ecfde67("player_trail_" + self.doa.color);
      model thread namespace_83eb6304::function_3ecfde67("glow_" + self.doa.color);
      distsq = distancesquared(target.origin, self.origin);
      time = mapfloat(0, sqr(1000), 0.25, 1, distsq);
      model moveto(target.origin, time);
      wait time;
      model delete();
    }

    if(isDefined(target)) {
      target.doa.var_7731eb4f = undefined;
      target.doa.score.lives++;
      target namespace_7f5aeb59::function_513831e1();

      if(self namespace_1c2a96f9::function_b01c3b20() && !forced) {
        target thread function_cdcf0e57(50);
      }
    }
  }
}

function giveaward(type, player) {
  assert(isDefined(player));
  player endon(#"disconnect");
  level namespace_dfc652ee::itemspawn(namespace_dfc652ee::function_6265bde4(type), player.origin, undefined, undefined, 1, undefined, undefined, undefined, player);
}

function function_cdcf0e57(range = 100) {
  self endon(#"disconnect");

  if(is_true(level.doa.hardcoremode)) {
    level thread giveaward("zombietron_chicken", self);
    wait 0.5;
    level thread giveaward("zombietron_coin", self);
    wait 0.5;
    level thread giveaward("zombietron_coin", self);
    return;
  }

  roll = randomint(range);

  if(roll == range - 1 && self.doa.score.lives < namespace_eccff4fb::function_77cbfb85()) {
    level thread giveaward("zombietron_extra_life", self);
    wait 0.5;
  }

  if(roll > 94 && self.doa.score.bombs < namespace_eccff4fb::function_4091beb5()) {
    level thread giveaward("zombietron_nuke", self);
    wait 0.5;
  }

  if(roll > 88) {
    level thread giveaward("zombietron_boxing_glove", self);
    wait 0.5;
  }

  if(roll > 75 && self.doa.score.boosts < namespace_eccff4fb::function_fd3d9ee0()) {
    level thread giveaward("zombietron_boost", self);
    wait 0.5;
  }

  if(roll > 50) {
    level thread giveaward("zombietron_chicken", self);
    wait 0.5;
    level thread giveaward("zombietron_chicken", self);
    wait 0.5;
  }

  if(roll > 35) {
    level thread giveaward("zombietron_sawblade", self);
    wait 0.5;
  }

  if(roll > 15) {
    level thread giveaward("zombietron_magnet", self);
    wait 0.5;
  }

  level thread giveaward("zombietron_chicken", self);
  wait 0.5;
  level thread giveaward("zombietron_ammo", self);
  wait 0.5;
  level thread giveaward("zombietron_ammo", self);
  wait 0.5;
  level thread giveaward("zombietron_ammo", self);
  wait 0.5;

  if(roll == 0) {
    level thread giveaward("zombietron_skeleton_key", self);
  }
}

function function_cf940b05() {
  if(is_true(level.var_7dcdbe16)) {
    return;
  }

  if(is_true(self.doa.var_4f3aee7b)) {
    return;
  }

  if(isDefined(self.doa.vehicle)) {
    if(is_true(self.doa.var_7a27ee1b)) {
      if(self function_e01d381a()) {
        return;
      }

      self.doa.var_7a27ee1b = undefined;
    }

    if(self function_e01d381a()) {
      self clientfield::increment_to_player("changeCamera");
      self notify(#"camera_changed");
      self.doa.var_7a27ee1b = 1;
    }

    return;
  }

  if(is_true(self.doa.var_7a27ee1b)) {
    if(self weaponswitchbuttonPressed() || self buttonbitstate("BUTTON_BIT_WEAPNEXT")) {
      return;
    }

    self.doa.var_7a27ee1b = undefined;
  }

  if(self weaponswitchbuttonPressed() || self buttonbitstate("BUTTON_BIT_WEAPNEXT")) {
    if(!is_true(self.doa.infps)) {
      self clientfield::increment_to_player("changeCamera");
    }

    self notify(#"camera_changed");
    self.doa.var_7a27ee1b = 1;
  }
}

function function_74ba13d0() {
  if(is_true(level.var_babb5873)) {
    return;
  }

  if(self namespace_491fa2b2::function_8f5419f1()) {
    return;
  }

  if(self useButtonPressed()) {
    self.doa.var_9d136ff8 = 1;
    return;
  }

  if(is_true(self.doa.var_9d136ff8)) {
    if(is_true(self.doa.var_af53a5b7)) {
      self.doa.var_9d136ff8 = undefined;
      self.doa.var_af53a5b7 = undefined;
      return;
    }

    if(isDefined(self.doa.vehicle)) {
      self notify(#"hash_279998c5df86c04d");
    } else {
      self namespace_41cb996::function_8b7acf56();
    }

    self.doa.var_9d136ff8 = undefined;
  }
}

function function_ba8327d7() {
  if(is_true(level.var_e1857dc3)) {
    return;
  }

  if(isDefined(self.doa.vehicle)) {
    return;
  }

  if(is_true(self.doa.var_9049062)) {
    return;
  }

  if(is_true(self.doa.var_c026f7c9)) {
    time = gettime();

    if(time < self.doa.var_fdc612e3) {
      self setvelocity(self.doa.var_b7001078);
      namespace_1e25ad94::debugmsg("Player(" + self.doa.color + ") BOOSTING active");

      if(self.doa.var_c0f32380 < time) {
        level notify(#"hash_50be6fd0db982086", {
          #origin: self.origin
        });
        self.doa.var_c0f32380 = time + 250;
      }

      return;
    }

    self.doa.var_c026f7c9 = 0;
    self thread namespace_7f5aeb59::turnplayershieldon();

    if(isDefined(self.doa.boosttrigger)) {
      self.doa.boosttrigger delete();
    }

    namespace_1e25ad94::debugmsg("Player(" + self.doa.color + ") BOOSTING deactivating");
  }

  if(is_true(self.doa.var_48d0af86)) {
    if(self secondaryoffhandbuttonPressed()) {
      return;
    }

    self.doa.var_48d0af86 = undefined;
  }

  if(self secondaryoffhandbuttonPressed() || is_true(self.doa.var_d524abd8)) {
    self.doa.var_d524abd8 = 0;
    self.doa.var_48d0af86 = 1;

    if(self.doa.score.boosts > 0) {
      self.doa.var_c026f7c9 = 1;
      self.doa.score.boosts--;
      self thread namespace_7f5aeb59::turnplayershieldon();
      forward = anglesToForward(self.angles);
      self namespace_e32bb68::function_3a59ec34("evt_doa_powerup_boost_activate");
      self.doa.boosttrigger = namespace_ec06fe4a::spawntrigger("trigger_radius", self.origin, 1 | 512 | 8, 80, 72);

      if(isDefined(self.doa.boosttrigger)) {
        self.doa.boosttrigger.targetname = "triggerBoost";
        self.doa.boosttrigger enablelinkto();
        self.doa.boosttrigger linkto(self, undefined, (200, 0, 0), self.angles);
        self.doa.boosttrigger.activetime = gettime() + 300;
        self.doa.boosttrigger thread namespace_7f5aeb59::function_19f387a(self, undefined, undefined, 1);
        self.doa.boosttrigger thread namespace_ec06fe4a::function_ae010bb4(self);
        self.doa.boosttrigger thread namespace_ec06fe4a::function_52afe5df(0.3);
      }

      self.doa.var_fdc612e3 = gettime() + 300;
      self.doa.var_b7001078 = forward * 2000;
      self.doa.var_b7001078 += (0, 0, 200);
      self setvelocity(self.doa.var_b7001078);
      self.doa.var_b7001078 -= (0, 0, 200);
      self.doa.var_c0f32380 = 0;
      self function_bc82f900("zombietron_booster_rumble");
    }
  }
}

function function_56544e8b() {
  if(is_true(level.var_52a59317)) {
    return;
  }

  if(!isalive(self)) {
    return;
  }

  if(isDefined(self.var_abe341a1)) {
    return;
  }

  if(is_true(self.doa.var_590072e2)) {
    return;
  }

  if(is_true(level.var_5e26061e)) {
    return;
  }

  if(isDefined(self.doa.var_21eab413)) {
    if(gettime() < self.doa.var_21eab413) {
      return;
    }

    self.doa.var_21eab413 = undefined;
  }

  if(is_true(self.doa.var_e6bdbae1)) {
    if(self fragButtonPressed()) {
      return;
    }

    self.doa.var_e6bdbae1 = undefined;
  }

  if(self fragButtonPressed() || is_true(self.doa.var_640df11b)) {
    self.doa.var_640df11b = 0;
    self.doa.var_e6bdbae1 = 1;

    if(self.doa.score.bombs > 0) {
      self.doa.score.bombs--;
      self thread function_a34cf3fb();
    }
  }
}

function function_a34cf3fb() {
  self endon(#"disconnect");
  player_org = self.origin;
  origin = player_org + (20, 0, 800);
  self thread namespace_7f5aeb59::turnplayershieldon();
  self clientfield::set("bombDrop", 1);
  wait 0.4;
  level notify(#"hash_c1cceae4479f2e5", {
    #origin: player_org
  });
  playrumbleonposition("artillery_rumble", self.origin);
  namespace_ec06fe4a::clearallcorpses();
  util::wait_network_frame();
  level notify(#"hash_11f6c6a82650cca2");

  if(namespace_4dae815d::function_59a9cf1d() != 0 || isDefined(level.doa.var_6f3d327)) {
    guys = getaiteamarray();

    if(!is_true(level.doa.var_61ee6067)) {
      var_bca95f5f = arraysortclosest(guys, self.origin, 60, 0, 768);
      guys = [];

      foreach(guy in var_bca95f5f) {
        if(abs(guy.origin[2] - self.origin[2]) > 512) {
          continue;
        }

        if(!isDefined(guys)) {
          guys = [];
        } else if(!isarray(guys)) {
          guys = array(guys);
        }

        guys[guys.size] = guy;
      }
    }
  } else {
    guys = getaiteamarray();
  }

  updir = vectornormalize(origin - player_org);
  var_182c1d00 = 0.3;

  foreach(guy in guys) {
    if(isDefined(guy)) {
      if(is_true(guy.var_c7121c91) || is_true(guy.boss)) {
        guy.nuked = gettime();
        guy ai::stun(randomfloatrange(3, 7));
        guy notify(#"nuked");
        continue;
      }

      guy.var_6dc6e670 = 1;

      if(isvehicle(guy)) {
        guy dodamage(guy.health + 1, player_org, self, self, "none", "MOD_EXPLOSIVE", 0, getweapon("none"));
        continue;
      }

      if(guy.team != "axis") {
        if(!is_true(guy.guardian)) {
          continue;
        }
      }

      guy thread function_6dc6e670(var_182c1d00, player_org, self, updir);
    }
  }

  util::wait_network_frame();
  self clientfield::set("bombDrop", 0);
  physicsexplosionsphere(player_org, 1024, 1024, 3);
}

function private function_6dc6e670(var_182c1d00, origin, player, updir) {
  self endon(#"death");
  assert(!is_true(self.boss));

  if(!isDefined(level.var_5c7cffec)) {
    level.var_5c7cffec = sqr(160);
    level.var_db768440 = sqr(512);
    level.var_ad08a14b = 75;
    level.var_3444cdb3 = 250;
    level.var_eb2c7de4 = 1;
  }

  distsq = distancesquared(self.origin, player);
  var_2ef058c8 = math::clamp(distsq / level.var_db768440, 0.1, 1);
  time = math::clamp(origin * var_2ef058c8, 0.05, origin);
  wait time;
  self.takedamage = 1;
  self.allowdeath = 1;
  self.var_418bd7f0 = 0;

  if(!is_true(self.no_gib)) {
    if(distsq < sqr(128) && !isDefined(self.boss)) {
      self namespace_ed80aead::function_586ef822();
    } else {
      self thread namespace_83eb6304::function_8b4b9bdd();

      if(!is_true(self.var_1b41b0e8) && isactor(self)) {
        self namespace_83eb6304::function_3ecfde67("burn_zombie");
      }

      self namespace_ed80aead::gib_random_part(self.health);
    }
  }

  if(self.archetype == "zombie") {
    roll = randomint(100);

    switch (randomint(4)) {
      case 0:
        self namespace_83eb6304::function_3ecfde67("boost_explode");
        break;
      case 1:
        self namespace_83eb6304::function_3ecfde67("gut_explode");
        break;
      case 2:
        self namespace_83eb6304::function_3ecfde67("saw_explode");
        break;
      default:
        break;
    }

    util::wait_network_frame();
  }

  self dodamage(self.health + 1, player, isDefined(updir) ? updir : undefined, undefined, "none", "MOD_EXPLOSIVE");
}

function callback_playerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, var_fd90b0bb, vdir, shitloc, psoffsettime, deathanimduration) {
  self endon(#"spawned", #"disconnect");
  self notify(#"killed_player");
  params = spawnStruct();
  params.einflictor = einflictor;
  params.eattacker = attacker;
  params.idamage = idamage;
  params.smeansofdeath = smeansofdeath;
  params.weapon = weapon;
  params.var_fd90b0bb = var_fd90b0bb;
  params.vdir = vdir;
  params.shitloc = shitloc;
  params.psoffsettime = psoffsettime;
  params.deathanimduration = deathanimduration;
  self callback::callback(#"on_player_killed", {});
}

function callback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal) {
  if(self getinvulnerability() || is_true(self.doa.var_221ef439)) {
    return;
  }

  time = gettime();

  if(smeansofdeath === # "mod_melee" && self.last_damaged_by === eattacker && isDefined(self.last_damaged_time)) {
    deltatime = time - self.last_damaged_time;

    if(deltatime < 100) {
      return;
    }
  }

  if(!isbot(self) && self arecontrolsfrozen()) {
    return;
  }

  if(isDefined(self.doa.var_cfe0bf1b) && time < self.doa.var_cfe0bf1b) {
    return;
  }

  if(smeansofdeath === "MOD_CRUSH") {
    if(isDefined(eattacker) && is_true(eattacker.var_bba2883e)) {
      return;
    }
  }

  if(smeansofdeath === "MOD_FALLING") {
    if(level flag::get("dungeon_building")) {
      return;
    }

    if(self.doa.var_dbe90a1f > 0) {
      self.doa.var_dbe90a1f--;
      return;
    }

    if(self.doa.var_9ff62c1c > 0) {
      idamage = math::clamp(idamage - self.doa.var_9ff62c1c, 0, idamage);
      self.doa.var_9ff62c1c = 0;
    }

    if(is_true(self.doa.var_9fa19717) || is_true(level.var_9fa19717) || namespace_4dae815d::function_59a9cf1d() == 0) {
      return;
    }

    if(idamage && idamage >= self.health) {
      idamage = math::clamp(self.health - 10, 0, self.health);
    }
  }

  if(self namespace_7f5aeb59::function_61bccc9()) {
    return;
  }

  if(isDefined(eattacker) && eattacker.team == self.team) {
    return;
  }

  if(isDefined(einflictor) && einflictor.team == self.team) {
    return;
  }

  idamage = int(idamage);
  originaldamage = idamage;

  if(level.doa.world_state == 0) {
    if(!is_true(eattacker.var_27860c49)) {
      if(weapon == level.doa.var_45c191a4 || weapon == level.doa.var_18a44fc1 || weapon == level.doa.var_ce403221) {
        idamage = 145;
        self.doa.var_cfe0bf1b = time + 500;
      } else if(smeansofdeath === "MOD_DOT") {
        idamage = idamage < 50 ? idamage : 50;
        self.doa.var_cfe0bf1b = time + 500;
      } else {
        idamage = self.maxhealth + 187;
      }
    } else {
      self.doa.var_cfe0bf1b = time + 1000;
    }
  }

  if(is_true(self.doa.infps)) {
    idamage = 65;

    if(is_true(eattacker.var_32c5c724)) {
      idamage = self.maxhealth - 1;
    }
  }

  if(smeansofdeath === "MOD_TRIGGER_HURT") {
    idamage = originaldamage;
  }

  self playrumbleonentity("damage_heavy");

  if(isDefined(self.doa.var_ccd8393c) && self.doa.var_ccd8393c > 0) {
    self.doa.var_ccd8393c--;

    if(self.doa.var_ccd8393c <= 0) {
      self notify(#"hash_226c5964dec34ae7");
      self.doa.var_cfe0bf1b = time + 1000;
    }

    return;
  }

  if(is_true(self.doa.infps)) {
    if(smeansofdeath !== "MOD_TRIGGER_HURT") {
      self.doa.var_cfe0bf1b = time + 1500;
    }
  }

  self.last_damaged_time = level.time;
  self.last_damaged_by = eattacker;
  self thread weapons::on_damage(eattacker, einflictor, weapon, smeansofdeath, idamage);
  self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
}

function callback_playerlaststand(einflictor, attacker, idamage, smeansofdeath, weapon, var_fd90b0bb, vdir, shitloc, psoffsettime, delayoverride) {
  if(self laststand::player_is_in_laststand()) {
    return;
  }

  self.deaths++;
  level.doa.var_465867b++;
  level.doa.var_bcc1fc05++;

  if(is_true(level.doa.var_41adf604)) {
    self.doa.var_2d965438++;
  }

  level notify(#"player_died", {
    #player: self
  });
  self notify(#"entering_last_stand");
  self notify(#"player_died");
  self.laststand = 1;
  self namespace_41cb996::function_8b7acf56();
  self clientfield::set_to_player("showMap", 0);
  self.doa.var_9ca03c2f = 0;
  self notsolid();

  if(isDefined(smeansofdeath) && isinarray(level.doa.var_5598fe58, smeansofdeath) && is_true(smeansofdeath.collector)) {
    level notify(#"hash_72523790f36bd2a8");
  }

  self namespace_e32bb68::function_3a59ec34("evt_doa_player_death");

  if(is_true(self.doa.infps) && self.doa.var_bb4d9604.size == 0) {
    self notify(#"hash_7893364bd228d63e");
  }

  namespace_1e25ad94::debugmsg("player entering last stand");
  delta = gettime() - self.doa.var_77c8b9d4;

  if(delta < 7000 || self namespace_7f5aeb59::function_61bccc9()) {
    namespace_1e25ad94::debugmsg("<dev string:xae>" + self.doa.color + "<dev string:xba>");
  }

  self.doa.var_77c8b9d4 = gettime();

  killedby = isDefined(smeansofdeath) && isDefined(smeansofdeath.zombie_type) ? smeansofdeath.zombie_type : "<dev string:xe4>";

  if(isDefined(smeansofdeath)) {
    if(isDefined(smeansofdeath.targetname)) {
      killedby = smeansofdeath.targetname;
    }
  }

  namespace_1e25ad94::debugmsg("<dev string:xae>" + self.doa.color + "<dev string:xf8>" + killedby);

  if(is_true(smeansofdeath.var_cd7dffa1) || getdvarint(#"hash_55b5b49e1b334929", 0) && isDefined(smeansofdeath)) {
    if(is_true(smeansofdeath.var_cd7dffa1)) {
      namespace_1e25ad94::debugmsg("<dev string:xae>" + self.doa.color + "<dev string:x10d>" + (isDefined(smeansofdeath) && isDefined(smeansofdeath.zombie_type) ? smeansofdeath.zombie_type : "<dev string:xe4>"), 1);
    }

    namespace_7f5aeb59::function_884143e(smeansofdeath);
  }

  self function_dc7906e8(idamage, smeansofdeath, weapon, var_fd90b0bb, vdir, shitloc, psoffsettime, delayoverride);

  if(isDefined(level.var_f7b64ada)) {
    [[level.var_f7b64ada]]();
  }

  self namespace_eccff4fb::function_f6ac4585();
  obituary(self, smeansofdeath, level.weaponnone, "MOD_DOWNED");
  self clientfield::set_to_player("lastStand", self.doa.score.lives < 0 ? 2 : 1);
  self allowjump(0);
  self namespace_7f5aeb59::laststand_disable_player_weapons();
  self.health = 5;
  self.laststand = 1;
  self.ignoreme = 1;
  self.ignoremelee = 1;
  callback::callback(#"on_player_laststand");

  if(self.doa.score.lives > 0) {
    bleedout_time = 5;

    if(self namespace_1c2a96f9::function_b01c3b20()) {
      bleedout_time = 3;
    }
  } else {
    if(!isDefined(level.doa.var_a4af7793)) {
      level.doa.var_a4af7793 = [];
    } else if(!isarray(level.doa.var_a4af7793)) {
      level.doa.var_a4af7793 = array(level.doa.var_a4af7793);
    }

    level.doa.var_a4af7793[level.doa.var_a4af7793.size] = self;
    bleedout_time = 60;

    if(self namespace_1c2a96f9::function_b01c3b20()) {
      bleedout_time = 30;
    }

    foreach(player in namespace_7f5aeb59::function_23e1f90f()) {
      if(player == self) {
        continue;
      }

      if(is_true(player.laststand)) {
        continue;
      }

      if(player.doa.score.lives < 1) {
        continue;
      }

      player namespace_6e90e490::showhint(7);
    }
  }

  if(getplayers().size > 1) {
    self thread namespace_7f5aeb59::function_52392bd1(bleedout_time == 60);
  }

  self thread namespace_7f5aeb59::function_77785447(1, 1);
  self thread laststand::function_d4c9e1b5();
  self thread function_49b2bfe5(bleedout_time);
}

function function_51e87eda() {
  self endon(#"disconnect");
  level endon(#"game_over");

  while(is_true(self.doa.respawning)) {
    self.doa.var_f64d2ac0 = 0;
    players = namespace_7f5aeb59::function_23e1f90f();

    foreach(player in players) {
      if(is_true(player.doa.respawning)) {
        continue;
      }

      if(isDefined(player.doa.vehicle)) {
        continue;
      }

      if(!isalive(player)) {
        continue;
      }

      distsq = distancesquared(self.origin, player.origin);
      var_c178b661 = player namespace_1c2a96f9::function_b01c3b20() ? sqr(72) : sqr(48);

      if(distsq > var_c178b661) {
        continue;
      }

      if(self namespace_1c2a96f9::function_b01c3b20() && player namespace_1c2a96f9::function_b01c3b20()) {
        self.doa.var_f64d2ac0 += 1;
        continue;
      }

      self.doa.var_f64d2ac0 += player.doa.var_96ca2395;
    }

    wait 1;
  }
}

function function_49b2bfe5(duration) {
  self endon(#"disconnect");
  self endon(#"player_respawned");
  level endon(#"game_over");
  var_82cfdf77 = duration > 5;
  self.doa.respawning = 1;
  self.doa.var_22e62f63 = duration * 1000;
  self.doa.var_ac8a92d4 = 0;
  self.doa.var_f64d2ac0 = 0;
  self thread function_51e87eda();
  var_58d202bd = float(function_60d95f53()) / 1000 * 1000;
  var_339d778e = 0;

  while(self.doa.var_ac8a92d4 < self.doa.var_22e62f63) {
    if(namespace_4dae815d::function_59a9cf1d() != 2) {
      if(var_82cfdf77 && self.doa.score.lives > 0) {
        break;
      }
    }

    waitframe(1);
    progress = var_58d202bd;

    if(self.doa.var_f64d2ac0 > 0) {
      progress += var_58d202bd * self.doa.var_f64d2ac0;
      time = gettime();

      if(time > var_339d778e) {
        self namespace_83eb6304::function_3ecfde67("player_healOS");
        var_339d778e = time + 2200;
      }
    } else {
      var_339d778e = 0;
    }

    self.doa.var_ac8a92d4 += progress;

    if(self getcurrentweapon() != level.laststandweapon) {
      self namespace_7f5aeb59::laststand_disable_player_weapons();
    }
  }

  self.laststandparams = undefined;
  self.var_bfc8055f = undefined;
  self notify(#"player_revived");
  self thread namespace_7f5aeb59::function_513831e1();
}

function function_dc7906e8(einflictor, attacker, idamage, smeansofdeath, weapon, var_fd90b0bb, vdir, shitloc) {
  self.laststandparams = spawnStruct();
  self.var_bfc8055f = spawnStruct();
  self.laststandparams.einflictor = einflictor;
  self.var_bfc8055f.var_b5346661 = isDefined(einflictor) ? einflictor getentitynumber() : -1;
  self.laststandparams.attacker = attacker;
  self.var_bfc8055f.attackernum = isDefined(attacker) ? attacker getentitynumber() : -1;
  self.laststandparams.attackerorigin = attacker.origin;

  if(isPlayer(attacker)) {
    self.laststandparams.attackerangles = attacker getplayerangles();
  } else {
    self.laststandparams.attackerangles = attacker.angles;
  }

  self.laststandparams.idamage = idamage;
  self.laststandparams.smeansofdeath = smeansofdeath;
  self.laststandparams.weapon = weapon;
  self.laststandparams.var_fd90b0bb = var_fd90b0bb;
  self.laststandparams.vdir = vdir;
  self.laststandparams.shitloc = shitloc;
  self.laststandparams.laststandstarttime = gettime();
  self.laststandparams.victimorigin = self.origin;
  self.laststandparams.victimangles = self getplayerangles();
  self.laststandparams.victimweapon = self.currentweapon;
  self.laststandparams.matchtime = gettime();
  self.laststandparams.bledout = 0;
  self.laststandparams.var_59b19c1b = 1;
}

function event_handler[enter_vehicle] codecallback_vehicleenter(eventstruct) {
  if(isvehicle(eventstruct.vehicle)) {
    vehicle = eventstruct.vehicle;
    var_7efce95 = 1;

    if(isDefined(vehicle.var_7efce95)) {
      var_7efce95 = vehicle.var_7efce95;
    }

    if(var_7efce95) {
      self.doa.var_9d136ff8 = 1;
      self.doa.var_1b452923 = 1;
      self thread namespace_a4bedd45::function_1f704cee(1, 0);
    }
  }
}

function event_handler[exit_vehicle] codecallback_vehicleexit(eventstruct) {
  if(is_true(self.doa.infps)) {
    self.doa.var_1b452923 = undefined;
    self notify(#"hash_7893364bd228d63e", {
      #var_cff8d1e: 1
    });
  }
}