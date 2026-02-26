/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_cartel.gsc
***********************************************/

#using script_44b0b8420eabacad;
#using script_67ce8e728d8f37ba;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\compass;
#using scripts\core_common\load_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;
#namespace mp_cartel;

function event_handler[level_init] main(eventstruct) {
  killstreaks::function_257a5f13("straferun", 40);
  killstreaks::function_257a5f13("helicopter_comlink", 75);
  level.missileremotelaunchvert = 9000;
  namespace_66d6aa44::function_3f3466c9();
  function_24198689();
  callback::on_end_game(&on_end_game);
  callback::function_6700e8b5(&function_aa95c0bb);

  if(getdvarstring(#"g_gametype") === "prop") {
    callback::on_spawned(&function_705159cd);
  }

  load::main();
  compass::setupminimap("");
  level thread function_bb57ca1a();
}

function function_24198689() {
  var_780f74b5 = [];
  var_780f74b5[var_780f74b5.size] = "mp_spawn_point";
  var_780f74b5[var_780f74b5.size] = "mp_spawn_point_axis";
  var_780f74b5[var_780f74b5.size] = "mp_spawn_point_allies";
  spawning::move_spawn_point(var_780f74b5, (902, 3489, 200.313), (935.51, 3913.98, 191.707), (0, -104.985, 0));
}

function function_aa95c0bb() {
  scene::add_scene_func("cin_mp_cartel_intro_north", &function_7a9eb99a, "init");
  scene::add_scene_func("cin_mp_cartel_intro_north", &function_9cb21c4a, "sh010");
  scene::add_scene_func("cin_mp_cartel_intro_north", &function_8337682d, "sh020");
}

function function_705159cd() {
  if(!self isprop()) {
    return;
  }

  self endon(#"death", #"disconnect");

  while(true) {
    if(isDefined(self.prop)) {
      prop = undefined;

      if(isDefined(self.propclones)) {
        foreach(clone in self.propclones) {
          if((clone.model === "p8_aml_chicken_female_02" || clone.model === "p8_aml_chicken_female_03") && !clone isplayinganimscripted()) {
            prop = clone;
            break;
          }
        }
      }

      if(!isDefined(prop)) {
        prop = self.prop;
      }

      if((prop.model === "p8_aml_chicken_female_02" || prop.model === "p8_aml_chicken_female_03") && !prop isplayinganimscripted()) {
        prop useanimtree("generic");
        prop animscripted("chicken_idle", prop.origin, prop.angles, "a_chicken_idle", "normal", "root", 1, 0);
      } else if(!(prop.model === "p8_aml_chicken_female_02" || prop.model === "p8_aml_chicken_female_03") && prop isplayinganimscripted()) {
        prop stopanimscripted();
      }
    }

    waitframe(1);
  }
}

function isprop() {
  return isDefined(self.pers[#"team"]) && self.pers[#"team"] == game.defenders;
}

function on_end_game() {}

function function_74906a8b(var_8f9fbf19) {
  var_56411b8a = getent("prb_tn_us_heli_lg_cockpit", "targetname");
  var_2ad45d4e = getent("prb_tn_us_heli_lg_cabin", "targetname");
  var_56411b8a unlink();
  var_2ad45d4e unlink();
  var_56411b8a dontinterpolate();
  var_2ad45d4e dontinterpolate();

  if(isDefined(var_8f9fbf19 gettagorigin("tag_probe_cockpit"))) {
    var_56411b8a linkto(var_8f9fbf19, "tag_probe_cockpit", (0, 0, 0), (0, 0, 0));
  }

  if(isDefined(var_8f9fbf19 gettagorigin("tag_probe_cabin"))) {
    var_2ad45d4e linkto(var_8f9fbf19, "tag_probe_cabin", (0, 0, 0), (0, 0, 0));
  }
}

function function_7a9eb99a(a_ents) {
  if(!isDefined(a_ents[#"hash_7adc8fdd333fd073"])) {
    iprintlnbold("<dev string:x38>");

    return;
  }

  function_74906a8b(a_ents[#"hash_7adc8fdd333fd073"]);
}

function function_9cb21c4a(a_ents) {
  if(!isDefined(a_ents[#"hash_7adc8fdd333fd073"])) {
    iprintlnbold("<dev string:x38>");

    return;
  }

  function_74906a8b(a_ents[#"hash_7adc8fdd333fd073"]);
}

function function_8337682d(a_ents) {
  if(!isDefined(a_ents[#"hash_7adc8fdd333fd073"])) {
    iprintlnbold("<dev string:x38>");

    return;
  }

  function_74906a8b(a_ents[#"hash_7adc8fdd333fd073"]);
}

function function_bb57ca1a() {
  var_c9a91b4a = array("dom10v10", "koth10v10", "war12v12", "tdm10v10");

  if(!isinarray(var_c9a91b4a, util::get_game_type())) {
    hidemiscmodels("pole_turret");
  }
}