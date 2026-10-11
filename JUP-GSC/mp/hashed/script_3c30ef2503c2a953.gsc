/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3c30ef2503c2a953.gsc
*************************************************/

#using script_5a4a5d9ba343ff8f;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\throttle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace zombie_health_bar;

function autoexec function_657dc7e018dcfce9() {
  utility::registersharedfunc("zombie_health_bar", "init", &function_84c0e1e271bafa7b);
}

function function_84c0e1e271bafa7b(var_7f99bc1f14808866, var_b15088d5cc05c0f9) {
  level callback::add("player_connect", &function_3894840410c9bf11);
  level.var_55ea2b11378ae8dd = throttle_initialize("zombie_health_bar_update", 2);

  if(!isDefined(level.var_84956ead4b0ba962)) {
    level.var_84956ead4b0ba962 = isDefined(var_7f99bc1f14808866) ? var_7f99bc1f14808866 : createentitytypemask(["etype_ai", "etype_vehicle", "etype_turret"]);
  }

  level.var_b5e278eb248c971d = isDefined(var_b15088d5cc05c0f9) && var_b15088d5cc05c0f9;

  if(!isDefined(level.var_e75d27acd726fe9c)) {
    level.var_e75d27acd726fe9c = 0;
  }
}

function function_3894840410c9bf11(params) {
  thread watch_target_health();
}

function update_target_health_variable(omnvarname, value, var_2be1ff56b5ef7757, var_79720293f809096b) {
  if(!isDefined(value)) {
    return;
  }

  value = int(min(value, 2147483646));
  var_e177082c5a0cb686 = isDefined(self.targethealthinfo[omnvarname]);
  var_547e3f9765be80bd = var_e177082c5a0cb686 && value != self.targethealthinfo[omnvarname];

  if(!var_e177082c5a0cb686 || var_547e3f9765be80bd) {
    self setclientomnvar(omnvarname, value);

    if(isDefined(var_2be1ff56b5ef7757) && isDefined(var_79720293f809096b) && var_547e3f9765be80bd && (isDefined(self.targethealthinfo["ui_target_entity_num"]) && var_79720293f809096b == self.targethealthinfo["ui_target_entity_num"] || isDefined(self.targethealthinfo["ui_target_scriptable_index"]) && var_79720293f809096b == self.targethealthinfo["ui_target_scriptable_index"])) {
      self setclientomnvar(var_2be1ff56b5ef7757, gettime());
    }

    self.targethealthinfo[omnvarname] = value;
  }
}

function watch_target_health() {
  self endon("disconnect");
  self.targethealthinfo = [];
  var_6f54922d8787736 = 0;
  var_cdbda03ce3d658b4 = 0;
  var_b933d4f13b0f6da2 = 0;
  savedentity = undefined;
  var_e2056d3211d33280 = 0;
  var_e167ed7a36b5375e = cos(30);
  setdvarifuninitialized(@ "hash_6d6c52eb3ebea9e6", 1000);
  var_578bc39651a16e6 = getdvarint(@ "hash_6d6c52eb3ebea9e6");

  while(true) {
    if(self.sessionstate != "playing") {
      waitframe();
      continue;
    }

    tracestart = self getEye();

    if(self getcamerathirdperson()) {
      tracestart = self getcamerathirdpersonorigin();
    }

    playerangles = self getplayerangles();
    playerlookdir = anglesToForward(playerangles);
    playerlookdir = vectorNormalize(playerlookdir);
    tracedist = 2500;

    if(self playerads() || isDefined(savedentity) && istrue(savedentity.var_1d6756d9fe7a5156)) {
      tracedist = 7500;
    }

    traceend = tracestart + playerlookdir * tracedist;
    traceradius = distance(tracestart, traceend);
    var_674bc7989105ce9 = 0;
    var_22aad45998b73e2a = getentitiesinradiusfrompartitiongrid(tracestart, traceradius, level.var_84956ead4b0ba962, [self]);

    if(isDefined(self.var_aae3feeeecfdc77f)) {
      var_22aad45998b73e2a = utility::array_combine_unique(var_22aad45998b73e2a, self.var_aae3feeeecfdc77f);
    }

    foreach(ent in var_22aad45998b73e2a) {
      if(!istrue(ent.var_1e0eb63ecb3f1e2) || !ent val::get("show_healthbar")) {
        continue;
      }

      if(vectordot(playerlookdir, vectorNormalize(ent.origin - self.origin)) > var_e167ed7a36b5375e) {
        var_674bc7989105ce9 = 1;
        break;
      }
    }

    waitframe();

    if(var_674bc7989105ce9) {
      ignoreents = [];
      ignoreents[ignoreents.size] = self;
      tracecontents = scripts\engine\trace::create_contents(1, 0, 0, 0, 1, 1, 1, 0, 0);
      results = scripts\engine\trace::ray_trace(tracestart, traceend, ignoreents, tracecontents, 0, 0, 1);
      hitentity = results["entity"];

      if(!isDefined(hitentity) && istrue(level.var_e75d27acd726fe9c) && isDefined(results["scriptable"])) {
        hitentity = results["scriptable"];
      }

      frametime = gettime();
      showentity = isDefined(hitentity) && istrue(hitentity.var_1e0eb63ecb3f1e2) && hitentity val::get("show_healthbar") && !(level.var_b5e278eb248c971d && hitentity.team == self.team);

      if(showentity) {
        var_6f54922d8787736 = 1;
      } else if(isDefined(savedentity)) {
        if(var_6f54922d8787736 && !istrue(savedentity.var_15d70cf838211daf)) {
          var_e2056d3211d33280 = frametime;
          var_6f54922d8787736 = 0;
          var_cdbda03ce3d658b4 = 1;
        }

        if(var_e2056d3211d33280 + var_578bc39651a16e6 > frametime) {
          hitentity = savedentity;
          showentity = 1;
        }

        if(istrue(savedentity.var_15d70cf838211daf)) {
          savedentity.var_15d70cf838211daf = 0;
          var_6f54922d8787736 = 0;
          var_cdbda03ce3d658b4 = 1;
          showentity = 0;
          savedentity = undefined;
        }
      }

      if(showentity) {
        if(isDefined(hitentity.var_4919d15787f01154)) {
          assert(!isDefined(hitentity.fake_health) || hitentity.fake_health <= 2147483646);
          assert(!isDefined(hitentity.max_fake_health) || hitentity.max_fake_health <= 2147483646);
        } else {
          assert(!isDefined(hitentity.health) || hitentity.health <= 2147483646);
          assert(!isDefined(hitentity.maxhealth) || hitentity.maxhealth <= 2147483646);
        }

        difficultyid = -1;

        if(isDefined(hitentity.difficulty) && isDefined(level.var_f721fc7d0d2d0f47) && isDefined(level.var_f721fc7d0d2d0f47.var_6ee86f7730b38593)) {
          difficultyid = level.var_f721fc7d0d2d0f47.var_6ee86f7730b38593[hitentity.difficulty];
        }

        stateid = 0;

        if(istrue(hitentity ent_flag("turned")) || hitentity function_8ce7894f1a52fb77("charm")) {
          stateid = 1;
        } else if(istrue(hitentity.iscompanion)) {
          stateid = 2;
        }

        typeid = default_to(hitentity.aitypeid, -1);
        nameindexid = default_to(hitentity.nameindex, 0);

        if(isent(hitentity)) {
          entitynum = hitentity getentitynumber();
          update_target_health_variable("ui_target_type", 0);
        } else if(level.var_e75d27acd726fe9c && hitentity isscriptableinstance()) {
          entitynum = hitentity function_fb10855b4bd8e58();
          update_target_health_variable("ui_target_type", 1);
        }

        update_target_health_variable("ui_target_enemy_type", typeid);
        update_target_health_variable("ui_target_enemy_difficulty", difficultyid);
        update_target_health_variable("ui_target_enemy_name_index", nameindexid);
        update_target_health_variable("ui_target_enemy_state", stateid, "ui_target_state_notify", entitynum);

        if(isDefined(hitentity.var_4919d15787f01154)) {
          update_target_health_variable("ui_target_max_health", hitentity.max_fake_health, "ui_target_health_notify", entitynum);
          update_target_health_variable("ui_target_health", hitentity.fake_health, "ui_target_health_notify", entitynum);
        } else {
          update_target_health_variable("ui_target_max_health", hitentity.maxhealth, "ui_target_health_notify", entitynum);
          update_target_health_variable("ui_target_health", hitentity.health, "ui_target_health_notify", entitynum);
        }

        update_target_health_variable("ui_target_healthbar_vis", 1);

        if(level.var_e75d27acd726fe9c) {
          if(isent(hitentity)) {
            update_target_health_variable("ui_target_entity_num", entitynum);
            update_target_health_variable("ui_target_scriptable_index", -1);
          } else if(hitentity isscriptableinstance()) {
            update_target_health_variable("ui_target_entity_num", -1);
            update_target_health_variable("ui_target_scriptable_index", entitynum);
          }
        } else {
          update_target_health_variable("ui_target_entity_num", entitynum);
        }

        savedentity = hitentity;
      } else if(var_cdbda03ce3d658b4) {
        update_target_health_variable("ui_target_type", 0);
        update_target_health_variable("ui_target_healthbar_vis", 0);
        update_target_health_variable("ui_target_entity_num", -1);

        if(level.var_e75d27acd726fe9c) {
          update_target_health_variable("ui_target_scriptable_index", -1);
        }

        var_cdbda03ce3d658b4 = 0;
      }

      if(isDefined(hitentity) && istrue(hitentity.var_9f009877c3bea958)) {
        function_cb0c83ad449f616(hitentity);
        var_b933d4f13b0f6da2 = 1;
      } else if(var_b933d4f13b0f6da2) {
        update_target_health_variable("ui_target_nameplate_vis", 0);
        var_b933d4f13b0f6da2 = 0;
      }
    } else if(isDefined(self.targethealthinfo["ui_target_entity_num"]) && self.targethealthinfo["ui_target_entity_num"] != -1 || isDefined(self.targethealthinfo["ui_target_scriptable_index"]) && self.targethealthinfo["ui_target_scriptable_index"] != -1) {
      update_target_health_variable("ui_target_type", 0);
      update_target_health_variable("ui_target_healthbar_vis", 0);
      update_target_health_variable("ui_target_entity_num", -1);

      if(level.var_e75d27acd726fe9c) {
        update_target_health_variable("ui_target_scriptable_index", -1);
      }
    }

    function_f632348cbb773537(level.var_55ea2b11378ae8dd, self);
  }
}

function function_cb0c83ad449f616(hitentity) {
  typeid = default_to(hitentity.aitypeid, -1);
  nameindexid = default_to(hitentity.nameindex, 0);
  entitynum = hitentity getentitynumber();
  update_target_health_variable("ui_target_type", 0);
  update_target_health_variable("ui_target_enemy_type", typeid);
  update_target_health_variable("ui_target_enemy_name_index", nameindexid);
  update_target_health_variable("ui_target_entity_num", entitynum);

  if(level.var_e75d27acd726fe9c) {
    update_target_health_variable("ui_target_scriptable_index", -1);
  }

  update_target_health_variable("ui_target_nameplate_vis", 1);
}