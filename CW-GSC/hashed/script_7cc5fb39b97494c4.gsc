/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_7cc5fb39b97494c4.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\weapons\weapons;
#namespace minigame;
class class_9e71c1a2 {
  var m_s_bundle;
  var m_str_identifier;
  var var_1c4a269e;
  var var_1d21e4f3;
  var var_2be76207;
  var var_3e29294f;
  var var_43773582;
  var var_63e8057;
  var var_6697e3b5;
  var var_678a6f36;
  var var_6dfc35a;
  var var_7529951f;
  var var_7f74e09b;
  var var_884c51e;
  var var_8b53fab0;
  var var_8ddd8026;
  var var_9e3fdeff;
  var var_a4ea555f;
  var var_b4563cfa;
  var var_b5a03b21;
  var var_bb0d53c3;
  var var_d411c5b6;
  var var_dc5b4677;
  var var_fcc5a4dd;

  constructor() {
    var_dc5b4677 = [];
    var_63e8057 = [];
    var_884c51e = [];
    var_6697e3b5 = [];
    var_bb0d53c3 = [];
    var_a4ea555f = [];
    var_1d21e4f3[#"allies"] = 0;
    var_1d21e4f3[#"axis"] = 0;
    var_1c4a269e = 0;
    var_7529951f = 0;
    var_fcc5a4dd = 0;
    var_678a6f36 = 0;
    var_d411c5b6 = 1;
    var_8ddd8026 = 1;
  }

  function function_70bcd27(s_minigame, s_bundle) {
    m_s_bundle = s_bundle;
    var_b5a03b21 = s_minigame;
    var_b5a03b21.var_ff3c99c5 = self;
    m_str_identifier = s_minigame.str_identifier;
    var_2be76207 = util::get_team_mapping(s_minigame.script_team);
    var_9e3fdeff = s_minigame.script_difficulty;

    switch (tolower(s_minigame.var_4e0f62f3)) {
      case # "open":
        var_8b53fab0 = 0;
        break;
      case # "exclusive":
        var_8b53fab0 = 1;
        break;
      case # "hash_65a466c611c44a94":
        var_8b53fab0 = 2;
        break;
    }

    var_6dfc35a = isDefined(s_minigame.var_3b6bc456) ? s_minigame.var_3b6bc456 : 0;

    if(is_true(s_minigame.var_a92a2cc0)) {
      var_fcc5a4dd = 1;
    }

    if(isDefined(var_b5a03b21.var_5ebe1cc1)) {
      var_d411c5b6 = var_b5a03b21.var_5ebe1cc1;
    }

    var_678a6f36 = is_true(s_minigame.var_3093fd62);

    if(isDefined(s_minigame.target)) {
      a_s_targets = struct::get_array(s_minigame.target);

      foreach(s_target in a_s_targets) {
        if(s_target scene::function_9503138e()) {
          if(!isDefined(var_a4ea555f)) {
            var_a4ea555f = [];
          } else if(!isarray(var_a4ea555f)) {
            var_a4ea555f = array(var_a4ea555f);
          }

          var_a4ea555f[var_a4ea555f.size] = s_target;
        }
      }
    }
  }

  function function_1633032e(e_player, interact_location, b_success) {
    if(scene::function_9730988a(interact_location.var_f8f0466c.scriptbundlename, "fail") && !b_success) {
      interact_location.var_f8f0466c scene::play("fail", e_player);
      return;
    }

    interact_location.var_f8f0466c scene::play("stop", e_player);
  }

  function function_225651c4(interact_location) {
    self endon(#"interact", #"disabled");
    interact_location.mdl_gameobject endon(#"death");
    var_29b8f3d0 = interact_location.mdl_gameobject waittill(#"gameobject_end_use_player");
    self notify(#"interact", {
      #e_player: var_29b8f3d0.player, #interact_location: interact_location
    });
  }

  function _reset(team) {}

  function function_2e32e924(e_player) {
    if(isDefined(e_player)) {
      arrayremovevalue(var_63e8057, undefined);

      if(isinarray(var_884c51e, e_player)) {
        arrayremovevalue(var_884c51e, e_player, 0);
      }

      if(!var_b5a03b21 flag::get("enabled")) {
        if(!isDefined(var_6697e3b5)) {
          var_6697e3b5 = [];
        } else if(!isarray(var_6697e3b5)) {
          var_6697e3b5 = array(var_6697e3b5);
        }

        if(!isinarray(var_6697e3b5, e_player)) {
          var_6697e3b5[var_6697e3b5.size] = e_player;
        }
      }

      if(var_63e8057.size == 1 && isDefined(var_63e8057[0].mdl_gameobject)) {
        var_63e8057[0].mdl_gameobject gameobjects::show_waypoint(e_player);
      }
    }
  }

  function _init() {}

  function function_37b8d51b(e_player) {
    if(!var_b5a03b21 flag::get("enabled")) {
      return false;
    }

    if(!isalive(e_player)) {
      return false;
    }

    if(e_player laststand::player_is_in_laststand()) {
      return false;
    }

    if(!var_7529951f && self function_d04f90d8(e_player)) {
      return false;
    }

    return true;
  }

  function function_422aeb75(e_player, interact_location, b_success) {
    if(isDefined(e_player)) {
      _stop(e_player);

      if(var_fcc5a4dd && isDefined(interact_location.mdl_gameobject)) {
        interact_location.mdl_gameobject gameobjects::show_waypoint(e_player);
        n_objective_id = interact_location.mdl_gameobject.objectiveid;
        objective_clearplayerusing(n_objective_id, e_player);
        objective_setgamemodeflags(n_objective_id, 0);
        objective_clearentity(n_objective_id);
      }

      e_player val::reset(#"minigame", "freezecontrols");
      e_player val::reset(#"minigame", "freezecontrols_allowlook");
      gameobjects::remove_player_use_modifiers(e_player);
      e_player endon(#"death");

      if(var_d411c5b6) {
        function_dd517e14(e_player, undefined);
        e_player weapons::function_d571ac59();

        if(self function_bb600dc2(e_player, b_success)) {
          e_player waittill(#"weapon_change_complete", #"death");
        }
      } else if(isDefined(interact_location.var_f8f0466c) && isalive(e_player) && !e_player inlaststand()) {
        if(is_true(var_b5a03b21.var_b0dfc0a2)) {
          self thread function_1633032e(e_player, interact_location, b_success);
        } else {
          self function_1633032e(e_player, interact_location, b_success);
        }
      } else if(e_player inlaststand()) {
        interact_location.var_f8f0466c scene::stop();
      }

      e_player.var_f4f7edb2 = undefined;
    }
  }

  function function_49c02476(e_player) {
    if(isDefined(e_player)) {
      if(isinarray(var_6697e3b5, e_player)) {
        arrayremovevalue(var_6697e3b5, e_player, 0);
      }

      if(!isDefined(var_884c51e)) {
        var_884c51e = [];
      } else if(!isarray(var_884c51e)) {
        var_884c51e = array(var_884c51e);
      }

      if(!isinarray(var_884c51e, e_player)) {
        var_884c51e[var_884c51e.size] = e_player;
      }

      foreach(interact_location in var_63e8057) {
        if(isDefined(interact_location) && isDefined(interact_location.mdl_gameobject)) {
          interact_location.mdl_gameobject gameobjects::hide_waypoint(e_player);
        }
      }
    }
  }

  function reset(str_team) {
    arrayremovevalue(var_bb0d53c3, str_team);

    if(!var_bb0d53c3.size) {
      var_b5a03b21 flag::clear("playing");
    }

    _reset(str_team);
  }

  function function_5ce6ff92(e_player) {
    if(isfunctionptr(level.var_84bcc5b0)) {
      e_player[[level.var_84bcc5b0]](self);
    }
  }

  function function_6084622f(e_player) {}

  function function_613e65ee(e_player) {}

  function function_673813fe(e_player) {
    if(isfunctionptr(level.var_e30ae574)) {
      e_player[[level.var_e30ae574]]();
    }
  }

  function function_699f084d() {
    if(is_true(var_b5a03b21.var_459e9174)) {
      self function_c6a410ce();
    }

    while(true) {
      s_notify = var_b5a03b21 waittill(#"hash_58b8542ed702b2a5");

      if(s_notify.var_36c9fd16) {
        self function_c6a410ce();
        continue;
      }

      var_63e8057[0] gameobjects::hide_waypoint();
    }
  }

  function function_70a50147(str_team) {
    foreach(e_player in getplayers(str_team)) {
      self function_49c02476(e_player);
    }
  }

  function _start(e_player) {}

  function disable() {
    var_b5a03b21 flag::clear("enabled");
    self notify(#"disabled");
    var_b5a03b21 notify(#"disabled");

    foreach(interact_location in var_63e8057) {
      if(isDefined(interact_location) && isDefined(interact_location.mdl_gameobject)) {
        interact_location.mdl_gameobject gameobjects::disable_object();
      }
    }
  }

  function failure(var_f8d01c02, e_player) {
    var_b5a03b21 flag::set("fail");

    foreach(interact_location in var_63e8057) {
      if(isDefined(interact_location) && isDefined(interact_location.mdl_gameobject)) {
        interact_location.mdl_gameobject gameobjects::enable_object();
      }
    }

    function_6084622f(e_player);
    self function_dc915c86(#"on_fail", e_player);

    if(is_true(var_b5a03b21.var_8f001ddb)) {
      self thread clean_up(0, 0, var_f8d01c02);
      return true;
    }

    return false;
  }

  function clean_up(var_a6bdeb0a, b_success, var_f8d01c02) {
    var_b5a03b21 flag::set("complete");
    self disable();

    if(!sessionmodeiscampaigngame() || !isDefined(level.var_3626dfc)) {
      foreach(interact_location in var_63e8057) {
        if(isDefined(interact_location)) {
          if(isDefined(interact_location.mdl_gameobject)) {
            interact_location.mdl_gameobject gameobjects::destroy_object(1);
          }

          if(isstruct(interact_location) && interact_location != var_b5a03b21) {
            interact_location struct::delete();
          }
        }
      }
    } else {
      foreach(interact_location in var_63e8057) {
        ent = interact_location;

        if(isDefined(interact_location.ent)) {
          ent = interact_location.ent;
        }

        if(isentity(ent)) {
          interact_location thread[[level.var_3626dfc]](#"use");

          if(isDefined(ent.var_645eee83)) {
            ent.var_645eee83 = undefined;
          }

          if(isDefined(ent.interact_location)) {
            ent.interact_location = undefined;
          }
        }

        if(isstruct(interact_location) && interact_location != var_b5a03b21) {
          interact_location struct::delete();
        }
      }
    }

    var_63e8057 = [];
  }

  function _stop(e_player) {}

  function function_8650ea49(s_minigame) {
    if(isDefined(var_b5a03b21.script_minigame_interact)) {
      var_f7e61134 = getEntArray(var_b5a03b21.script_minigame_interact, "script_minigame_interact");
      var_4d8ab49e = struct::get_array(var_b5a03b21.script_minigame_interact, "script_minigame_interact");
      var_4d8ab49e = array::filter(var_4d8ab49e, 0, &minigame::function_ad13b048);
      var_63e8057 = arraycombine(var_f7e61134, var_4d8ab49e, 0, 0);
    } else {
      var_63e8057 = array(var_b5a03b21);
    }

    if(isDefined(var_b5a03b21.script_gameobject)) {
      var_5f7d7d0d = var_b5a03b21.script_gameobject;
    } else {
      var_5f7d7d0d = m_s_bundle.gameobject;
    }

    str_objective = undefined;

    if(isDefined(var_b5a03b21.script_objective_override)) {
      str_objective = var_b5a03b21.script_objective_override;
    }

    if(var_2be76207 == # "any") {
      var_2b5577a7 = # "any";
    } else if(var_678a6f36) {
      var_2b5577a7 = var_2be76207;
    } else {
      var_2b5577a7 = util::get_enemy_team(var_2be76207);
    }

    if(!sessionmodeiscampaigngame() || !isDefined(level.var_6a7fb742)) {
      foreach(interact_location in var_63e8057) {
        interact_location.var_3093fd62 = var_678a6f36;
        interact_location gameobjects::init_game_objects(var_5f7d7d0d, var_2b5577a7, undefined, undefined, undefined, str_objective);

        if(!var_678a6f36 && var_2be76207 != # "any") {
          interact_location.mdl_gameobject gameobjects::allow_use(#"group_enemy");
          interact_location.mdl_gameobject gameobjects::set_visible(#"group_enemy");
        }

        interact_location.mdl_gameobject.s_minigame = var_b5a03b21;
        interact_location.mdl_gameobject.b_reusable = 1;
        interact_location.mdl_gameobject.b_auto_reenable = 0;
        interact_location.mdl_gameobject gameobjects::disable_object();

        if(isDefined(var_b5a03b21.var_4cd30731)) {
          interact_location gameobjects::set_key_object(var_b5a03b21.var_4cd30731);

          if(is_true(var_b5a03b21.script_destroy_keys_after_use)) {
            interact_location gameobjects::function_e7e3d146();
          }
        }
      }

      if(var_63e8057.size > 1) {
        self thread function_a5f97adb();
      }

      return;
    }

    foreach(interact_location in var_63e8057) {
      ent = interact_location;

      if(isDefined(interact_location.ent)) {
        ent = interact_location.ent;
      }

      if(isentity(ent)) {
        bundle = getscriptbundle(var_5f7d7d0d);
        image = undefined;

        if(isDefined(bundle.objective)) {
          image = function_b91948e(bundle.objective);

          if(image == # "") {
            image = undefined;
          }
        }

        prompt_text = bundle.str_hint;
        var_de6f0004 = isDefined(bundle.n_trigger_use_time) ? bundle.n_trigger_use_time : 0;
        ent.var_645eee83 = self;
        ent.interact_location = interact_location;
        ent thread[[level.var_6a7fb742]](#"use", {
          #prompt_text: prompt_text, #image: image, #var_71b9f0c0: 200, #offset: interact_location.var_80778410, #var_754bedbb: 0, #var_87c991f3: 40, #var_de6f0004: var_de6f0004, #var_be77841a: 0, #var_531201f1: &minigame::function_cc2939a2, #complete_callback: &minigame::function_76974d96, #var_c9643122: 1, #var_67eb3347: &minigame::function_eb28f36
        });
      }
    }
  }

  function run(s_minigame, s_bundle) {
    self function_70bcd27(s_minigame, s_bundle);
    self function_8650ea49(s_bundle);
    _init();

    if(is_true(var_b5a03b21.script_enable_on_start)) {
      self thread enable();
    }
  }

  function function_89999e9c(player, stream) {}

  function function_904b9a29(var_f8d01c02) {
    s_result = self waittill(#"complete", "complete_" + var_f8d01c02);
    return s_result.b_success;
  }

  function function_91ef58fb(var_f8d01c02) {}

  function can_use(e_player) {
    if(!var_b5a03b21 flag::get("enabled")) {
      return false;
    }

    if(!isalive(e_player) || is_true(e_player.var_f4f7edb2) || e_player scene::is_igc_active()) {
      return false;
    }

    if(var_8b53fab0 == 2 && isinarray(var_bb0d53c3, e_player.team)) {
      return false;
    }

    if(e_player getstance() == "prone") {
      return false;
    }

    return true;
  }

  function complete(e_player, b_success, team) {
    if(var_8b53fab0 == 2 && isDefined(team)) {
      str_notify = "complete_" + team;
    } else {
      str_notify = "complete";
    }

    if(b_success && isDefined(team)) {
      var_1d21e4f3[team] = 1;
    }

    self notify(str_notify, {
      #b_success: b_success
    });
    level notify(#"minigame_complete", {
      #e_player: e_player, #minigame: self, #b_success: b_success, #team: team
    });
  }

  function function_97132cce(e_player, interact_location) {
    if(isDefined(e_player)) {
      gameobjects::apply_player_use_modifiers(e_player);
      e_player.var_f4f7edb2 = 1;
      e_player.var_97c1c267 = var_b5a03b21;
      var_b5a03b21.last_player = e_player;

      if(is_true(var_1c4a269e)) {
        e_player val::set(#"minigame", "freezecontrols");
      } else {
        e_player val::set(#"minigame", "freezecontrols_allowlook");
      }

      if(isDefined(interact_location.script_minigame_scene)) {
        if(!isDefined(interact_location.var_f8f0466c)) {
          var_a64cfd9c = struct::get_script_bundle_instances("scene", array(interact_location.script_minigame_scene, "script_minigame_scene"));
          assert(var_a64cfd9c.size == 1, "<dev string:x1aa>");
          interact_location.var_f8f0466c = var_a64cfd9c[0];
        }

        var_21f2d623 = "start";

        if(scene::function_9730988a(interact_location.var_f8f0466c.scriptbundlename, "restart")) {
          if(is_true(interact_location.var_f8f0466c.is_restart)) {
            var_21f2d623 = "restart";
          } else {
            interact_location.var_f8f0466c.is_restart = 1;
          }
        }

        interact_location.var_f8f0466c thread scene::play(var_21f2d623, e_player);
        e_player waittilltimeout(15, #"weapon_change_complete", #"minigame_ready");
      } else if(var_d411c5b6) {
        function_dd517e14(e_player, m_s_bundle.weapon, 1);
      }

      _start(e_player);
    }
  }

  function function_97aa68af() {
    self endon(#"disabled");
    var_b90f0ac2 = undefined;

    while(true) {
      foreach(interact_location in var_63e8057) {
        if(isDefined(interact_location) && isDefined(interact_location.mdl_gameobject)) {
          b_show_objective = !isDefined(var_b90f0ac2) || interact_location.mdl_gameobject !== var_b90f0ac2 || !var_fcc5a4dd;
          var_b90f0ac2 = undefined;
          interact_location.mdl_gameobject gameobjects::enable_object(undefined, b_show_objective);
          self thread function_225651c4(interact_location);
        }
      }

      var_29b8f3d0 = self waittill(#"interact");
      e_player = var_29b8f3d0.e_player;
      var_67f3d9ac = var_29b8f3d0.interact_location;
      var_67f3d9ac.var_1754f288 = 1;
      var_b90f0ac2 = var_67f3d9ac.mdl_gameobject;

      foreach(interact_location in var_63e8057) {
        if(isDefined(interact_location) && isDefined(interact_location.mdl_gameobject)) {
          var_ffd61eb5 = interact_location !== var_67f3d9ac || !var_fcc5a4dd;
          interact_location.mdl_gameobject gameobjects::disable_object(undefined, var_ffd61eb5);
        }
      }

      if(var_fcc5a4dd) {
        var_67f3d9ac.mdl_gameobject gameobjects::hide_waypoint(e_player);
        n_objective_id = var_67f3d9ac.mdl_gameobject.objectiveid;
        var_3e29294f = objective_team(n_objective_id);
        objective_setplayerusing(n_objective_id, e_player);
        objective_setteam(n_objective_id, e_player.team);
        objective_setgamemodeflags(n_objective_id, 1);
        objective_onentity(n_objective_id, e_player);
      }

      var_f8d01c02 = e_player.team;

      if(self can_use(e_player)) {
        self thread function_e43bda22(e_player, var_f8d01c02, var_67f3d9ac);

        if(var_8b53fab0 == 1) {
          self function_904b9a29(var_f8d01c02);
        }
      }
    }
  }

  function function_9e6bea30(str_team) {
    foreach(e_player in getplayers(str_team)) {
      self function_2e32e924(e_player);
    }
  }

  function success(var_f8d01c02, e_player) {
    var_b5a03b21 flag::set("success");

    if(isDefined(var_b5a03b21.script_flag_set)) {
      util::function_aebdb74f(var_b5a03b21.script_flag_set);
    }

    if(!is_true(var_7f74e09b)) {
      foreach(s_scene in var_a4ea555f) {
        s_scene thread scene::play();
      }
    }

    function_e28586b3(e_player);
    self function_dc915c86(#"on_success", e_player);

    if(is_true(var_b5a03b21.script_delete)) {
      self thread clean_up(0, 1, var_f8d01c02);
      return true;
    }

    var_1d21e4f3[var_f8d01c02] = 0;
    return false;
  }

  function function_a466ed26(e_player) {}

  function function_a5f97adb() {
    var_27e76749 = 0;

    while(true) {
      if(isDefined(var_b5a03b21.var_4cd30731) && is_true(var_b5a03b21.var_4cd30731.script_toggle_lock_visibility)) {
        if(!is_true(var_b5a03b21.var_459e9174) && !var_27e76749) {
          var_27e76749 = 1;
        } else if(is_true(var_b5a03b21.var_459e9174) && var_27e76749) {
          var_27e76749 = 0;
        }
      }

      foreach(e_player in getplayers(var_2be76207)) {
        if(isinarray(var_884c51e, e_player)) {
          continue;
        }

        if(!var_b5a03b21 flag::get("enabled") && !isinarray(var_6697e3b5, e_player)) {
          continue;
        }

        if(var_b5a03b21 flag::get("playing")) {
          foreach(interact_location in var_63e8057) {
            if(is_true(interact_location.var_1754f288)) {
              interact_location.mdl_gameobject gameobjects::show_waypoint(e_player);
              continue;
            }

            interact_location.mdl_gameobject gameobjects::hide_waypoint(e_player);
          }

          continue;
        }

        var_dbfda451 = array::get_all_closest(e_player.origin, var_63e8057);

        if(!var_27e76749) {
          var_1bfdf9f9 = array::pop_front(var_dbfda451, 0).mdl_gameobject;
          var_1bfdf9f9 gameobjects::show_waypoint(e_player);
        }

        foreach(interact_location in var_dbfda451) {
          interact_location.mdl_gameobject gameobjects::hide_waypoint(e_player);
        }
      }

      wait 0.25;
    }
  }

  function function_bb600dc2(e_player, b_success) {
    if(!isalive(e_player) || e_player inlaststand() || !b_success) {
      return false;
    }

    return true;
  }

  function enable() {
    if(var_b5a03b21 flag::get("enabled")) {
      return;
    }

    if(is_true(var_8ddd8026)) {
      var_8ddd8026 = undefined;
      var_b5a03b21 util::function_fb80e9ca();
    }

    self reset();
    level flag::wait_till("all_players_connected");
    var_b5a03b21 flag::set("enabled");
    self thread function_97aa68af();

    foreach(interact_location in var_63e8057) {
      if(isDefined(interact_location) && isDefined(interact_location.mdl_gameobject)) {
        interact_location.mdl_gameobject gameobjects::enable_object();
      }
    }

    if(var_63e8057.size == 1) {
      if(isDefined(var_b5a03b21.var_4cd30731) && is_true(var_b5a03b21.var_4cd30731.script_toggle_lock_visibility)) {
        self thread function_699f084d();
        return;
      }

      self function_c6a410ce();
    }
  }

  function function_c6a410ce() {
    if(var_678a6f36) {
      var_d045c932 = # "any";
    } else {
      var_d045c932 = var_2be76207;
    }

    var_6678b09c = getplayers(var_d045c932);
    var_6678b09c = array::exclude(var_6678b09c, var_884c51e);

    foreach(e_player in var_6678b09c) {
      var_63e8057[0] gameobjects::show_waypoint(e_player);
    }
  }

  function function_c72c3d4c(e_player, var_f8d01c02) {
    self endon(#"complete", "complete" + var_f8d01c02);
    waitframe(1);

    while(self function_37b8d51b(e_player) && e_player isswitchingweapons()) {
      waitframe(1);
    }

    function_a466ed26(e_player);

    while(self function_37b8d51b(e_player)) {
      function_613e65ee(e_player);
      waitframe(1);
    }

    function_d04f90d8(e_player);
    b_success = function_91ef58fb(var_f8d01c02);

    if(b_success) {
      self complete(e_player, 1, var_f8d01c02);
      return;
    }

    self complete(e_player, 0, var_f8d01c02);
  }

  function function_c8ad03f4(e_player) {
    e_player endon(#"disconnect");

    if(!isDefined(e_player.var_ff7ce13b)) {
      e_player.var_ff7ce13b = [];
    }

    if(!isDefined(e_player.var_ff7ce13b[m_s_bundle.type])) {
      e_player.var_ff7ce13b[m_s_bundle.type] = 0;
    }

    if(!e_player.var_ff7ce13b[m_s_bundle.type] && isDefined(var_b4563cfa)) {
      function_5ce6ff92(e_player);
      s_waitresult = e_player waittill(#"minigame_tutorial_complete", #"hash_226f6717c97d10d6", #"death", #"entering_last_stand");
      function_673813fe(e_player);

      if(s_waitresult._notify === "minigame_tutorial_complete") {
        e_player.var_ff7ce13b[m_s_bundle.type] = 1;
      }
    }
  }

  function function_d04f90d8(e_player) {
    if(e_player stancebuttonPressed()) {
      e_player notify(#"hash_226f6717c97d10d6");
      return true;
    }

    return false;
  }

  function function_dc915c86(str_callback, ...) {
    if(isDefined(var_b5a03b21.var_bb0149e5) && isDefined(var_b5a03b21.var_bb0149e5[str_callback])) {
      foreach(s_callback in var_b5a03b21.var_bb0149e5[str_callback]) {
        a_args = arraycombine(vararg, s_callback.params, 1, 0);

        if(s_callback.b_thread) {
          util::single_thread_argarray(var_b5a03b21, s_callback.func, a_args);
          continue;
        }

        util::single_func_argarray(var_b5a03b21, s_callback.func, a_args);
      }
    }
  }

  function function_dd517e14(e_player, weapon, var_e689a5b8) {
    if(isDefined(var_43773582)) {
      if(var_43773582 === weapon) {
        return;
      }

      e_player takeweapon(var_43773582);
    }

    var_43773582 = weapon;

    if(!isDefined(level.var_f425c7f3)) {
      level.var_f425c7f3 = [];
    } else if(!isarray(level.var_f425c7f3)) {
      level.var_f425c7f3 = array(level.var_f425c7f3);
    }

    if(!isinarray(level.var_f425c7f3, weapon)) {
      level.var_f425c7f3[level.var_f425c7f3.size] = weapon;
    }

    if(isDefined(weapon)) {
      e_player giveweapon(weapon);
      e_player switchtoweapon(weapon, 1);

      if(is_true(var_e689a5b8)) {
        e_player endon(#"death");
        e_player waittill(#"weapon_change_complete");
      }
    }
  }

  function function_e25c39ec(e_player) {
    if(isDefined(var_63e8057[0])) {
      var_63e8057[0] gameobjects::function_f4ccb04c(e_player);
    }
  }

  function function_e28586b3(e_player) {}

  function function_e43bda22(e_player, var_f8d01c02, interact_location) {
    var_b5a03b21 flag::set("playing");
    var_b5a03b21 flag::clear("success");
    var_b5a03b21 flag::clear("fail");

    if(isDefined(var_b5a03b21.script_flag_set_start)) {
      util::function_aebdb74f(var_b5a03b21.script_flag_set_start);
    }

    if(!isDefined(var_bb0d53c3)) {
      var_bb0d53c3 = [];
    } else if(!isarray(var_bb0d53c3)) {
      var_bb0d53c3 = array(var_bb0d53c3);
    }

    if(!isinarray(var_bb0d53c3, var_f8d01c02)) {
      var_bb0d53c3[var_bb0d53c3.size] = var_f8d01c02;
    }

    self function_49c02476(e_player);
    self function_dc915c86(#"on_start", e_player);

    if(isbot(e_player)) {
      e_player thread minigame::function_ab30c8b9(var_b5a03b21);
    }

    self function_97132cce(e_player, interact_location);
    self thread function_c8ad03f4(e_player);
    self thread function_c72c3d4c(e_player, var_f8d01c02);
    b_success = self function_904b9a29(var_f8d01c02);
    var_b5a03b21 flag::clear("playing");
    interact_location.var_1754f288 = undefined;

    if(isDefined(var_3e29294f)) {
      if(isDefined(interact_location.mdl_gameobject)) {
        objective_setteam(interact_location.mdl_gameobject.objectiveid, var_3e29294f);
      }

      var_3e29294f = undefined;
    }

    self function_422aeb75(e_player, interact_location, b_success);

    if(b_success) {
      b_delete = self success(var_f8d01c02, e_player);
    } else {
      b_delete = self failure(var_f8d01c02, e_player);
    }

    if(b_delete) {
      return;
    }

    self reset(var_f8d01c02);
    self function_2e32e924(e_player);
  }
}

function private event_handler[createstruct] function_e0a8e4ba(struct) {
  foreach(var_8041af38, k in ["script_minigame_interact"]) {
    if(!isDefined(level.var_41204f29)) {
      level.var_41204f29 = [];
    } else if(!isarray(level.var_41204f29)) {
      level.var_41204f29 = array(level.var_41204f29);
    }

    if(!isinarray(level.var_41204f29, tolower(k))) {
      level.var_41204f29[level.var_41204f29.size] = tolower(k);
    }
  }

  level.var_5e990e96 = arraycopy(level.var_41204f29);

  if(isDefined(level.struct)) {
    temp = arraycopy(level.struct);
    level.struct = [];

    foreach(struct in temp) {
      struct::init(struct);
    }
  }

  function_6c07201b("CreateStruct", &function_e0a8e4ba);
}

function private autoexec __init__system__() {
  system::register("minigames", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  if(!isDefined(level.var_b6bac679)) {
    level.var_b6bac679 = [];
  }

  if(!isDefined(level.var_1e600ced)) {
    level.var_1e600ced = [];
  }

  if(!isDefined(level.var_f425c7f3)) {
    level.var_f425c7f3 = [];
  }

  function_71699fe2();
  serverfield::register("minigame_progress", 1, 3, "int", &notify_progress);
}

function private postinit() {
  function_e6adabd1();
  function_374e4d47();
}

function function_fef35085(kvp) {
  var_b6bac679 = self function_358b4546(kvp);

  foreach(s_minigame in var_b6bac679) {
    if(s_minigame flag::get("complete")) {
      continue;
    }

    assert(isDefined(s_minigame.var_ff3c99c5), "<dev string:x38>");
    [[s_minigame.var_ff3c99c5]] - > clean_up(1);
    s_minigame.var_ff3c99c5 = undefined;
  }
}

function function_903cc131(kvp, e_player) {
  var_b6bac679 = self function_358b4546(kvp);

  foreach(s_minigame in var_b6bac679) {
    if(s_minigame flag::get("complete")) {
      continue;
    }

    assert(isDefined(s_minigame.var_ff3c99c5), "<dev string:x38>");
    [[s_minigame.var_ff3c99c5]] - > function_e25c39ec(e_player);
  }
}

function function_c09ff52(kvp, team, e_player) {
  var_b6bac679 = self function_358b4546(kvp);

  foreach(s_minigame in var_b6bac679) {
    if(s_minigame flag::get("complete")) {
      continue;
    }

    assert(isDefined(s_minigame.var_ff3c99c5), "<dev string:x38>");
    [[s_minigame.var_ff3c99c5]] - > complete(e_player, 0, team);
  }
}

function function_d6209a68(kvp, team, e_player) {
  var_b6bac679 = self function_358b4546(kvp);

  foreach(s_minigame in var_b6bac679) {
    if(s_minigame flag::get("complete")) {
      continue;
    }

    assert(isDefined(s_minigame.var_ff3c99c5), "<dev string:x38>");
    [[s_minigame.var_ff3c99c5]] - > complete(e_player, 1, team);
  }
}

function function_9f42562e(kvp, b_success) {
  var_b6bac679 = self function_358b4546(b_success);

  foreach(s_minigame in var_b6bac679) {
    if(s_minigame flag::get("complete") || !s_minigame flag::get("enabled")) {
      continue;
    }

    assert(isDefined(s_minigame.var_ff3c99c5), "<dev string:x88>");
    [[s_minigame.var_ff3c99c5]] - > disable();
  }
}

function function_fa6cc037(kvp) {
  var_b6bac679 = self function_358b4546(kvp);

  foreach(s_minigame in var_b6bac679) {
    if(s_minigame flag::get("complete") || s_minigame flag::get("enabled")) {
      continue;
    }

    assert(isDefined(s_minigame.var_ff3c99c5), "<dev string:x38>");
    [[s_minigame.var_ff3c99c5]] - > enable();
  }
}

function function_15491eef(kvp, team) {
  var_b6bac679 = self function_358b4546(kvp);

  foreach(s_minigame in var_b6bac679) {
    if(s_minigame flag::get("complete")) {
      continue;
    }

    assert(isDefined(s_minigame.var_ff3c99c5), "<dev string:x38>");
    [[s_minigame.var_ff3c99c5]] - > reset(team);
  }
}

function function_f214347f(kvp, e_player) {
  var_b6bac679 = self function_358b4546(kvp);

  foreach(s_minigame in var_b6bac679) {
    if(s_minigame flag::get("complete")) {
      continue;
    }

    assert(isDefined(s_minigame.var_ff3c99c5), "<dev string:x38>");
    [[s_minigame.var_ff3c99c5]] - > function_49c02476(e_player);
  }
}

function function_326c59f1(kvp, e_player) {
  var_b6bac679 = self function_358b4546(kvp);

  foreach(s_minigame in var_b6bac679) {
    if(s_minigame flag::get("complete")) {
      continue;
    }

    assert(isDefined(s_minigame.var_ff3c99c5), "<dev string:x38>");
    [[s_minigame.var_ff3c99c5]] - > function_2e32e924(e_player);
  }
}

function function_382e90e0(kvp, str_team) {
  var_b6bac679 = self function_358b4546(kvp);

  foreach(s_minigame in var_b6bac679) {
    if(s_minigame flag::get("complete")) {
      continue;
    }

    assert(isDefined(s_minigame.var_ff3c99c5), "<dev string:x38>");
    [[s_minigame.var_ff3c99c5]] - > function_70a50147(str_team);
  }
}

function function_1d72032b(kvp, str_team) {
  var_b6bac679 = self function_358b4546(kvp);

  foreach(s_minigame in var_b6bac679) {
    if(s_minigame flag::get("complete")) {
      continue;
    }

    assert(isDefined(s_minigame.var_ff3c99c5), "<dev string:x38>");
    [[s_minigame.var_ff3c99c5]] - > function_9e6bea30(str_team);
  }
}

function on_start(kvp, var_72b833ec, b_thread = 0, ...) {
  var_b6bac679 = self function_358b4546(kvp);

  foreach(s_minigame in var_b6bac679) {
    if(!isDefined(s_minigame.var_bb0149e5)) {
      s_minigame.var_bb0149e5 = [];
    }

    if(!isDefined(s_minigame.var_bb0149e5[#"on_start"])) {
      s_minigame.var_bb0149e5[#"on_start"] = [];
    }

    var_1c8482a6 = {
      #func: var_72b833ec, #b_thread: b_thread, #params: vararg
    };

    if(!isDefined(s_minigame.var_bb0149e5[#"on_start"])) {
      s_minigame.var_bb0149e5[#"on_start"] = [];
    } else if(!isarray(s_minigame.var_bb0149e5[#"on_start"])) {
      s_minigame.var_bb0149e5[#"on_start"] = array(s_minigame.var_bb0149e5[#"on_start"]);
    }

    if(!isinarray(s_minigame.var_bb0149e5[#"on_start"], var_1c8482a6)) {
      s_minigame.var_bb0149e5[#"on_start"][s_minigame.var_bb0149e5[#"on_start"].size] = var_1c8482a6;
    }
  }
}

function on_success(kvp, var_248486f4, b_thread = 0, ...) {
  var_b6bac679 = self function_358b4546(kvp);

  foreach(s_minigame in var_b6bac679) {
    if(!isDefined(s_minigame.var_bb0149e5)) {
      s_minigame.var_bb0149e5 = [];
    }

    if(!isDefined(s_minigame.var_bb0149e5[#"on_success"])) {
      s_minigame.var_bb0149e5[#"on_success"] = [];
    }

    var_89d033d3 = {
      #func: var_248486f4, #b_thread: b_thread, #params: vararg
    };

    if(!isDefined(s_minigame.var_bb0149e5[#"on_success"])) {
      s_minigame.var_bb0149e5[#"on_success"] = [];
    } else if(!isarray(s_minigame.var_bb0149e5[#"on_success"])) {
      s_minigame.var_bb0149e5[#"on_success"] = array(s_minigame.var_bb0149e5[#"on_success"]);
    }

    if(!isinarray(s_minigame.var_bb0149e5[#"on_success"], var_89d033d3)) {
      s_minigame.var_bb0149e5[#"on_success"][s_minigame.var_bb0149e5[#"on_success"].size] = var_89d033d3;
    }
  }
}

function on_fail(kvp, var_1ea9b69a, b_thread = 0, ...) {
  var_b6bac679 = self function_358b4546(kvp);

  foreach(s_minigame in var_b6bac679) {
    if(!isDefined(s_minigame.var_bb0149e5)) {
      s_minigame.var_bb0149e5 = [];
    }

    if(!isDefined(s_minigame.var_bb0149e5[#"on_fail"])) {
      s_minigame.var_bb0149e5[#"on_fail"] = [];
    }

    var_dfab6f1b = {
      #func: var_1ea9b69a, #b_thread: b_thread, #params: vararg
    };

    if(!isDefined(s_minigame.var_bb0149e5[#"on_fail"])) {
      s_minigame.var_bb0149e5[#"on_fail"] = [];
    } else if(!isarray(s_minigame.var_bb0149e5[#"on_fail"])) {
      s_minigame.var_bb0149e5[#"on_fail"] = array(s_minigame.var_bb0149e5[#"on_fail"]);
    }

    if(!isinarray(s_minigame.var_bb0149e5[#"on_fail"], var_dfab6f1b)) {
      s_minigame.var_bb0149e5[#"on_fail"][s_minigame.var_bb0149e5[#"on_fail"].size] = var_dfab6f1b;
    }
  }
}

function function_7dc9b185(str_type = undefined) {
  if(isDefined(str_type)) {
    var_b6bac679 = level.var_1e600ced[str_type];
  } else {
    var_b6bac679 = level.var_b6bac679;
  }

  if(isDefined(self) && isDefined(var_b6bac679) && isinarray(var_b6bac679, self)) {
    return true;
  }

  return false;
}

function function_ee73e88e(var_4ebba909, kvp) {
  var_b6bac679 = [];

  if(isDefined(var_4ebba909)) {
    var_b6bac679 = level.var_1e600ced[var_4ebba909];
  } else {
    var_b6bac679 = level.var_b6bac679;
  }

  if(var_b6bac679.size > 0 && isDefined(kvp)) {
    if(isarray(kvp)) {
      str_value = kvp[0];
      str_key = kvp[1];
    } else {
      str_value = kvp;
      str_key = "targetname";
    }

    var_b6bac679 = function_7b8e26b3(var_b6bac679, str_value, str_key);
  }

  return var_b6bac679;
}

function function_7afabfe2(kvp) {
  var_b6bac679 = self function_358b4546(kvp);
  assert(var_b6bac679.size == 1, "<dev string:xd1>");

  foreach(s_minigame in var_b6bac679) {
    assert(isDefined(s_minigame.var_ff3c99c5), "<dev string:x148>");
    return s_minigame.var_ff3c99c5.var_8b53fab0;
  }
}

function function_839316c5(kvp) {
  var_b6bac679 = self function_358b4546(kvp);
  assert(var_b6bac679.size == 1, "<dev string:xd1>");

  foreach(s_minigame in var_b6bac679) {
    assert(isDefined(s_minigame.var_ff3c99c5), "<dev string:x148>");
    return s_minigame.var_ff3c99c5.var_9e3fdeff;
  }
}

function function_7dcd3a3b(kvp) {
  var_b6bac679 = self function_358b4546(kvp);
  assert(var_b6bac679.size == 1, "<dev string:xd1>");

  foreach(s_minigame in var_b6bac679) {
    assert(isDefined(s_minigame.var_ff3c99c5), "<dev string:x148>");
    return s_minigame.var_ff3c99c5.var_6dfc35a;
  }
}

function function_6f5dfae7(kvp) {
  var_b6bac679 = self function_358b4546(kvp);
  assert(var_b6bac679.size == 1, "<dev string:xd1>");

  foreach(s_minigame in var_b6bac679) {
    assert(isDefined(s_minigame.var_ff3c99c5), "<dev string:x148>");
    return s_minigame.var_ff3c99c5.var_63e8057;
  }
}

function function_c68ebedc(kvp) {
  var_b6bac679 = self function_358b4546(kvp);

  foreach(s_minigame in var_b6bac679) {
    if(s_minigame flag::get("complete")) {
      continue;
    }

    s_minigame flag::wait_till("success");
  }
}

function function_b3798a53(kvp) {
  var_b6bac679 = self function_358b4546(kvp);

  foreach(s_minigame in var_b6bac679) {
    if(s_minigame flag::get("complete")) {
      continue;
    }

    s_minigame flag::wait_till("fail");
  }
}

function function_3c605058(kvp) {
  var_b6bac679 = self function_358b4546(kvp);

  foreach(s_minigame in var_b6bac679) {
    if(s_minigame flag::get("complete")) {
      continue;
    }

    s_minigame flag::wait_till("playing");
  }
}

function function_63673f23(s_minigame, str_type) {
  if(!isDefined(level.var_b6bac679)) {
    level.var_b6bac679 = [];
  } else if(!isarray(level.var_b6bac679)) {
    level.var_b6bac679 = array(level.var_b6bac679);
  }

  level.var_b6bac679[level.var_b6bac679.size] = s_minigame;

  if(!isDefined(level.var_1e600ced[str_type])) {
    level.var_1e600ced[str_type] = [];
  } else if(!isarray(level.var_1e600ced[str_type])) {
    level.var_1e600ced[str_type] = array(level.var_1e600ced[str_type]);
  }

  level.var_1e600ced[str_type][level.var_1e600ced[str_type].size] = s_minigame;
  s_minigame init_flags();

  if(isDefined(s_minigame.targetname)) {
    s_minigame.str_identifier = s_minigame.targetname + "_" + level.var_1e600ced[str_type].size;
    return;
  }

  s_minigame.str_identifier = str_type + "_" + level.var_1e600ced[str_type].size;
}

function private function_71699fe2() {
  foreach(str_type in array("threerings", "hackdoor", "spinners", "cryptopad", "lockpick")) {
    foreach(s_minigame in struct::get_script_bundle_instances("minigame_" + str_type)) {
      function_63673f23(s_minigame, str_type);
    }
  }
}

function private init_flags() {
  self flag::init("playing");
  self flag::init("enabled");
  self flag::init("success");
  self flag::init("fail");
  self flag::init("complete");

  if(isDefined(self.script_flag_true)) {
    util::create_flags_and_return_tokens(self.script_flag_true);
  }

  if(isDefined(self.script_flag_set_start)) {
    util::create_flags_and_return_tokens(self.script_flag_set_start);
  }

  if(isDefined(self.script_flag_set)) {
    util::create_flags_and_return_tokens(self.script_flag_set);
  }
}

function private function_e6adabd1() {
  waittillframeend();

  foreach(s_minigame in level.var_b6bac679) {
    s_bundle = getscriptbundle(s_minigame.scriptbundlename);
    var_ff3c99c5 = [[level.var_51e24470[s_bundle.type]]]();
    [[var_ff3c99c5]] - > run(s_minigame, s_bundle);
  }

  level flag::set(#"hash_ead1c2fc78eb61c");
}

function private function_374e4d47() {
  foreach(var_7418aa09 in trigger::get_all()) {
    var_178e6cb5 = [];

    foreach(s_minigame in level.var_b6bac679) {
      if(isDefined(var_7418aa09) && isDefined(var_7418aa09.target) && var_7418aa09.target === s_minigame.targetname) {
        if(!isDefined(var_178e6cb5)) {
          var_178e6cb5 = [];
        } else if(!isarray(var_178e6cb5)) {
          var_178e6cb5 = array(var_178e6cb5);
        }

        var_178e6cb5[var_178e6cb5.size] = s_minigame;
      }
    }

    if(var_178e6cb5.size) {
      var_7418aa09 thread function_cfb72f6(var_178e6cb5);
    }
  }
}

function private function_cfb72f6(var_178e6cb5) {
  self endon(#"death");
  self trigger::wait_till();
  var_178e6cb5 function_fa6cc037();
}

function private function_ab30c8b9(s_minigame) {
  self endon(#"death", #"entering_last_stand");
  level endon(#"game_ended");
  var_d5d783f8 = [1: 6, 2: 8, 3: 10, 4: 12];
  playtime = var_d5d783f8[s_minigame.var_ff3c99c5.var_9e3fdeff];
  playtime += randomfloatrange(-1, 1);
  wait playtime;

  if(isDefined(s_minigame)) {
    team = s_minigame function_7afabfe2() == 2 ? self.team : undefined;
    s_minigame function_d6209a68(undefined, team, self);
  }
}

function function_cc2939a2(prompt_struct) {
  if(isDefined(self.var_645eee83)) {
    return [[self.var_645eee83]] - > can_use(prompt_struct.player);
  }

  return 0;
}

function function_76974d96(prompt_struct) {
  if(isDefined(self.var_645eee83)) {
    thread[[self.var_645eee83]] - > function_e43bda22(prompt_struct.player, prompt_struct.player getteam(), self.interact_location);
  }
}

function function_eb28f36(prompt_struct) {
  if(isDefined(self.var_645eee83)) {
    thread[[self.var_645eee83]] - > function_89999e9c(prompt_struct.player, 1);
  }
}

function private function_358b4546(kvp, str_type = undefined) {
  var_b6bac679 = [];

  if(isDefined(kvp)) {
    if(isarray(kvp)) {
      str_value = kvp[0];
      str_key = kvp[1];
    } else {
      str_value = kvp;
      str_key = "targetname";
    }

    var_b6bac679 = struct::get_array(str_value, str_key);
  } else {
    var_b6bac679 = self;

    if(!isDefined(var_b6bac679)) {
      var_b6bac679 = [];
    } else if(!isarray(var_b6bac679)) {
      var_b6bac679 = array(var_b6bac679);
    }
  }

  var_b6bac679 = array::filter(var_b6bac679, 0, &function_e154102f, str_type);
  assert(var_b6bac679.size, "<dev string:x1e4>");
  return var_b6bac679;
}

function private function_e154102f(var_ac1d69cd, str_type) {
  return var_ac1d69cd function_7dc9b185(str_type);
}

function private function_ad13b048(var_ac1d69cd, str_type) {
  return !var_ac1d69cd function_7dc9b185(str_type);
}

function function_27a6b226(var_92e792ba, var_72b833ec, var_248486f4, var_1ea9b69a) {
  assert("<dev string:x236>");
}

function function_7a0057f8(dud, var_e66d95c, var_208a7da3, var_e71d96e, var_20b57df5, var_ecf31671, var_c722cad1) {
  assert("<dev string:x236>");
}

function notify_progress(oldval, newval) {
  e_player = self;

  if(is_true(e_player.var_f4f7edb2) && e_player == e_player.var_97c1c267.last_player) {
    s_minigame = e_player.var_97c1c267;
    var_847964c = float(newval) / float(8 - 1);
    s_minigame.var_ff3c99c5 notify(#"minigame_progress", {
      #e_player: e_player, #minigame: e_player.var_97c1c267, #var_477d921d: var_847964c
    });
  }
}