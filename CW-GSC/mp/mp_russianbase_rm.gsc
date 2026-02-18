/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_russianbase_rm.gsc
***********************************************/

#using scripts\core_common\compass;
#using scripts\core_common\load_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#namespace mp_russianbase_rm;

function event_handler[level_init] main(eventstruct) {
  load::main();
  compass::setupminimap("");
  prematch_init();
}

function prematch_init() {
  if(getgametypesetting(#"allowmapscripting")) {
    level thread init_train();
  }
}

function init_train() {
  level endon(#"game_ended");
  level scene::add_scene_func(#"hash_2084b22fe6837c77", &function_bfe6ca0b, "init");
  level scene::add_scene_func(#"hash_2084b22fe6837c77", &function_43561aca, "play");
  level scene::add_scene_func(#"hash_2084b22fe6837c77", &function_963b1a99, "done");
  level scene::init(#"hash_2084b22fe6837c77");

  while(true) {
    if(math::cointoss()) {
      level scene::play(#"hash_2084b22fe6837c77");
    }

    wait randomintrange(100, 130);
  }
}

function function_bfe6ca0b(a_ents) {
  a_ents[# "prop 1"] hide();
  self.t_hurt = getent("train_hurt_trig", "targetname");
  self.t_hurt.start_pos = self.t_hurt.origin;
  self.t_hurt enablelinkto();
}

function function_43561aca(a_ents) {
  a_ents[# "prop 1"] show();

  if(isDefined(self.t_hurt)) {
    self.t_hurt linkto(a_ents[# "prop 1"]);
  }
}

function function_963b1a99(a_ents) {
  a_ents[# "prop 1"] hide();

  if(isDefined(self.t_hurt)) {
    self.t_hurt unlink();
    self.t_hurt.origin = self.t_hurt.start_pos;
  }
}