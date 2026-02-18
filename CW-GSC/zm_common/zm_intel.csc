/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_intel.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace zm_intel;

function private autoexec __init__system__() {
  system::register(#"zm_intel", &preinit, undefined, undefined, undefined);
}

function preinit() {
  clientfield::register("scriptmover", "" + # "hash_475f3329eaf62eaf", 1, 1, "int", &function_63960208, 0, 0);
  clientfield::register("toplayer", "" + # "hash_1a818fdb4337dc5e", 1, 1, "counter", &function_3a2dd570, 0, 0);
  clientfield::register("toplayer", "" + # "hash_711c8fee28432b7", 1, getminbitcountfornum(28), "int", &function_5fa73633, 0, 0);
  level.var_238bd723 = struct::get_script_bundle_instances("zmintel");
  level.var_604b606e = struct::get_array("zm_intel_radio_transmission_locations");
  callback::on_localclient_connect(&on_localclient_connect);
}

function function_7bd1ca93(localclientnum, str_targetname, player) {
  s_intel = self;

  if(isDefined(str_targetname)) {
    s_intel = struct::get(str_targetname);
  }

  if(isDefined(s_intel.scriptbundlename) && !isDefined(s_intel.mdl_intel) && player function_f0f36d47(localclientnum, s_intel.scriptbundlename)) {
    s_bundle = getscriptbundle(s_intel.scriptbundlename);

    if(isDefined(s_bundle.model) && s_bundle.var_9be0526e === # "audiolog") {
      s_intel.mdl_intel = util::spawn_anim_model(localclientnum, s_bundle.model, s_intel.origin, s_intel.angles);
      s_intel.mdl_intel.var_2b372cf6 = s_bundle.var_9be0526e;
      s_intel.mdl_intel.str_faction = s_bundle.var_ad4ad686;
      s_intel.mdl_intel.var_d5fa8477 = s_intel.scriptbundlename;
      s_intel.mdl_intel.script_flag_true = s_intel.script_flag_true;
    } else {
      return;
    }

    if(s_intel.mdl_intel.var_2b372cf6 === # "audiolog") {
      switch (s_intel.mdl_intel.str_faction) {
        case # "maxis":
          s_intel.mdl_intel setModel(#"p9_zm_ndu_audiolog_player");
          s_intel.mdl_intel.str_client_scene = # "p9_zm_ndu_audiolog_player_bundle";
          break;
        case # "requiem":
          s_intel.mdl_intel setModel(#"p9_zm_ndu_audiolog_player_requiem");
          s_intel.mdl_intel.str_client_scene = # "p9_zm_ndu_audiolog_player_requiem_bundle";
          break;
        case # "omega":
          s_intel.mdl_intel setModel(#"p9_zm_ndu_reel_to_reel_audio_recorder_01");
          s_intel.mdl_intel.str_client_scene = # "p9_zm_ndu_reel_to_reel_audio_recorder_01_bundle";
          break;
      }
    }

    if(isDefined(s_intel.modelscale) && s_intel.modelscale != 1) {
      s_intel.mdl_intel setscale(s_intel.modelscale);
    }
  }
}

function private on_localclient_connect(localclientnum) {
  level thread function_ded2880a(localclientnum);
}

function function_63960208(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    self.var_a60e0aca = util::playFXOnTag(fieldname, #"zombie/fx_powerup_on_caution_zmb", self, "tag_origin");
    return;
  }

  if(isDefined(self.var_a60e0aca)) {
    stopfx(fieldname, self.var_a60e0aca);
    self.var_a60e0aca = undefined;
  }
}

function function_3a2dd570(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    if(!isDefined(self.var_e2ab3227)) {
      self.var_e2ab3227 = [];
    }

    v_eye = self getEye();
    s_intel = arraygetclosest(v_eye, level.var_238bd723, 120);

    if(!isDefined(s_intel)) {
      foreach(var_495fa1f8 in level.var_238bd723) {
        if(isDefined(var_495fa1f8.target)) {
          var_bd62a504 = struct::get(var_495fa1f8.target, "targetname");

          if(isDefined(var_bd62a504) && distance(v_eye, var_bd62a504.origin) < 120) {
            s_intel = var_495fa1f8;
            break;
          }
        }
      }
    }

    if(!isDefined(s_intel)) {
      s_intel = arraygetclosest(v_eye, level.var_604b606e, 120);
    }

    if(!(self function_8e51b4f(3) || self function_8e51b4f(5)) || !isDefined(s_intel) || isDefined(s_intel.mdl_intel) && isinarray(self.var_e2ab3227, s_intel.mdl_intel)) {
      mdl_intel = self.var_e2ab3227[0];
      arrayremoveindex(self.var_e2ab3227, 0);

      if(isDefined(mdl_intel)) {
        mdl_intel stopallloopsounds(0.5);
        wait 0.5;
      }

      if(isDefined(mdl_intel.str_client_scene)) {
        mdl_intel scene::stop(mdl_intel.str_client_scene);
      }

      if(isDefined(mdl_intel)) {
        mdl_intel delete();
      }

      return;
    }

    if(isDefined(s_intel.model) && (self function_8e51b4f(3) || self function_8e51b4f(5))) {
      switch (s_intel.model) {
        case # "p9_zm_ndu_reel_to_reel_audio_recorder_01":
        case # "p9_zm_ndu_audiolog_player":
        case # "p9_zm_ndu_audiolog_player_requiem":
          if(!isDefined(s_intel.mdl_intel)) {
            s_intel function_7bd1ca93(fieldname, undefined, self);

            if(isDefined(s_intel.mdl_intel) && isDefined(s_intel.target)) {
              var_bd62a504 = struct::get(var_495fa1f8.target, "targetname");

              if(isDefined(var_bd62a504)) {
                s_intel.mdl_intel.origin = var_bd62a504.origin;
                s_intel.mdl_intel.angles = var_bd62a504.angles;
              }
            }
          }

          if(isDefined(s_intel.mdl_intel) && isDefined(s_intel.mdl_intel.str_client_scene)) {
            s_intel.mdl_intel thread scene::play(s_intel.mdl_intel.str_client_scene, s_intel.mdl_intel);

            if(!isDefined(self.var_e2ab3227)) {
              self.var_e2ab3227 = [];
            } else if(!isarray(self.var_e2ab3227)) {
              self.var_e2ab3227 = array(self.var_e2ab3227);
            }

            if(!isinarray(self.var_e2ab3227, s_intel.mdl_intel)) {
              self.var_e2ab3227[self.var_e2ab3227.size] = s_intel.mdl_intel;
            }
          }

          break;
        case # "p9_zm_ndu_radio_transmissions":
        case # "p9_zm_ndu_radio_transmissions_o":
        case # "p9_zm_ndu_radio_transmissions_r":
          if(!isDefined(s_intel.mdl_intel)) {
            s_intel.mdl_intel = util::spawn_anim_model(fieldname, #"tag_origin", s_intel.origin, s_intel.angles);

            if(!isDefined(self.var_e2ab3227)) {
              self.var_e2ab3227 = [];
            } else if(!isarray(self.var_e2ab3227)) {
              self.var_e2ab3227 = array(self.var_e2ab3227);
            }

            if(!isinarray(self.var_e2ab3227, s_intel.mdl_intel)) {
              self.var_e2ab3227[self.var_e2ab3227.size] = s_intel.mdl_intel;
            }
          }

          s_intel.mdl_intel.var_a25d63cc = s_intel.mdl_intel playLoopSound(#"hash_5e90e65fa1abb6d0");
          break;
        default:
          break;
      }
    }
  }
}

function function_5fa73633(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self.var_8e6c13e2 = bwasdemojump;
}

function function_88645994(var_6f94d397, var_c14aedb3, var_539eabc0, var_765715e3, var_d5f7338b) {
  level.var_9ff51719 = var_6f94d397;
  level.var_64d3d5c4 = var_c14aedb3;
  level.var_13ebf509 = var_539eabc0;
  level.var_1e898375 = var_765715e3;
  level.var_b131552c = var_d5f7338b;
}

function function_f0f36d47(localclientnum, var_d5fa8477) {
  if(self === function_27673a7(localclientnum) && isDefined(var_d5fa8477) && stats::get_match_stat(localclientnum, 0, #"hash_118b6e7581ca3893", var_d5fa8477)) {
    return true;
  }

  return false;
}

function function_1a594d26(localclientnum, var_d5fa8477) {
  foreach(player in getplayers(localclientnum)) {
    if(!player function_f0f36d47(localclientnum, var_d5fa8477)) {
      return false;
    }
  }

  return true;
}

function function_2bcfd899(localclientnum, var_f84ece9f, var_2b372cf6) {
  if(isDefined(level.var_fa1d4366)) {
    var_d5fa8477 = level.var_fa1d4366;
    level.var_fa1d4366 = undefined;
    return var_d5fa8477;
  }

  switch (var_2b372cf6) {
    case # "hash_76270a10851f51d8":
      var_bf0df48d = level.var_9ff51719;
      break;
    case # "hash_71c51f24f7f3037d":
      var_bf0df48d = level.var_64d3d5c4;
      break;
    case # "hash_405e81feb85c5162":
      var_bf0df48d = level.var_13ebf509;
      break;
    case # "hash_6fec31948ca2058c":
      var_bf0df48d = level.var_1e898375;
      break;
    case # "hash_28fec49f37a535b9":
      var_bf0df48d = level.var_b131552c;
      break;
    default:
      assertmsg("<dev string:x38>");
      return;
  }

  if(!isDefined(var_bf0df48d)) {
    println("<dev string:x76>" + var_2b372cf6);
    return;
  }

  var_71b26808 = getscriptbundle(var_bf0df48d);

  if(!isarray(var_71b26808.var_572513bb) || !var_71b26808.var_572513bb.size) {
    return;
  }

  if(var_2b372cf6 === # "hash_71c51f24f7f3037d") {
    n_index = self clientfield::get_to_player("" + # "hash_711c8fee28432b7");
    var_d5fa8477 = var_71b26808.var_572513bb[n_index].var_cb9cd317;
    return var_d5fa8477;
  }

  foreach(var_a36fa2c6 in var_71b26808.var_572513bb) {
    if(var_a36fa2c6.season === # "hash_3c8cc59cdaa4bb29") {
      continue;
    }

    if(!self function_f0f36d47(var_f84ece9f, var_a36fa2c6.var_cb9cd317)) {
      return var_a36fa2c6.var_cb9cd317;
    }
  }
}

function function_12e3769(var_d5fa8477) {
  if(!isDefined(var_d5fa8477)) {
    return;
  }

  var_19a3087c = getscriptbundle(var_d5fa8477);
  return var_19a3087c.var_6073bf8f;
}

function function_ded2880a(localclientnum) {
  util::init_dvar(#"hash_42041dee5640342d", "<dev string:xb7>", &function_fd0c6ab2);
  util::init_dvar(#"hash_472c425964c7d41e", "<dev string:xb7>", &function_fd0c6ab2);
  var_3132e3d3 = util::get_map_name();
  var_65679637 = getscriptbundlenames("<dev string:xbb>");

  foreach(var_d5fa8477 in var_65679637) {
    var_d5fa8477 = function_9e72a96(var_d5fa8477);
    s_bundle = getscriptbundle(var_d5fa8477);

    if(isDefined(s_bundle)) {
      if(isDefined(s_bundle.var_ad4ad686)) {
        str_faction = function_9e72a96(s_bundle.var_ad4ad686);
      } else {
        str_faction = "<dev string:xc6>";
      }

      if(isDefined(s_bundle.var_9be0526e)) {
        str_type = function_9e72a96(s_bundle.var_9be0526e);
      } else {
        str_type = "<dev string:xd4>";
      }

      if(isDefined(s_bundle.season)) {
        var_7e4f1bf = "<dev string:xdf>" + s_bundle.season;
      } else {
        var_7e4f1bf = "<dev string:xea>";
      }

      var_2b65c1ac = str_faction + "<dev string:xf7>" + str_type + "<dev string:xf7>" + var_7e4f1bf + "<dev string:xf7>" + var_d5fa8477;
    } else {
      var_2b65c1ac = var_d5fa8477;
    }

    if(s_bundle.mapname !== var_3132e3d3) {
      continue;
    }

    util::add_devgui(localclientnum, "<dev string:xfc>" + var_2b65c1ac + "<dev string:x117>", "<dev string:x138>" + var_d5fa8477 + "<dev string:x15d>");

    if(s_bundle.var_ad4ad686 === # "dark_aether") {
      util::add_devgui(localclientnum, "<dev string:xfc>" + var_2b65c1ac + "<dev string:x162>", "<dev string:x180>" + var_d5fa8477 + "<dev string:x15d>");
    }
  }
}

function function_fd0c6ab2(params) {
  if(params.value === "<dev string:xb7>") {
    return;
  }

  switch (params.name) {
    case # "hash_42041dee5640342d":
      s_bundle = getscriptbundle(params.value);
      var_e915a27 = getent(0, "<dev string:x19c>", "<dev string:x1b5>");

      if(isDefined(s_bundle.var_6073bf8f)) {
        var_e915a27 setModel(s_bundle.var_6073bf8f);
      }

      break;
    case # "hash_472c425964c7d41e":
      if(function_1a594d26(0, params.value)) {
        iprintlnbold("<dev string:x1c3>" + params.value);
      } else {
        iprintlnbold("<dev string:x1e6>" + params.value + "<dev string:x1f0>");
        level.var_fa1d4366 = params.value;
      }

      break;
  }

  setDvar(#"hash_42041dee5640342d", "<dev string:xb7>");
  setDvar(#"hash_472c425964c7d41e", "<dev string:xb7>");
}