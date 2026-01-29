/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\dog\dog_init.gsc
****************************************/

#using_animtree("dog");

main() {
  self useanimtree(#animtree);
  _id_3AF2();
  animscripts\init::_id_20C5();
  self.ignoresuppression = 1;
  self.newenemyreactiondistsq = 0;
  self._id_0AAB = 0;
  self.nododgemove = 1;
  self._id_0C56 = % root;
  self.meleeattackdist = 0;
  thread _id_3AEF();
  self.a = spawnStruct();
  self.a._id_0D26 = "stand";
  self.a._id_0D14 = 0;
  self.a._id_0D2B = "run";
  animscripts\init::_id_20BE();
  self._id_0CFB = 1;
  self._id_117F = 0;
  self.stopanimdistsq = anim._id_3AEE;
  self.usechokepoints = 0;
  self.turnrate = 0.2;
  thread animscripts\combat_utility::monitorflash();
  self.pathenemyfightdist = 512;
  self settalktospecies("dog");
  self.health = int(anim._id_22EB * self.health);
}

_id_3AEF() {
  self endon("death");

  for(;;) {
    if(isDefined(self.enemy) && isplayer(self.enemy)) {
      self.meleeattackdist = anim._id_3AF0;
    } else {
      self.meleeattackdist = anim._id_3AF1;

    }
    self waittill("enemy");
  }
}

_id_3AF2() {
  if(!isDefined(level._id_3AF3)) {
    level._id_3AF3 = 1;
    precachestring(&"SCRIPT_PLATFORM_DOG_DEATH_DO_NOTHING");
    precachestring(&"SCRIPT_PLATFORM_DOG_DEATH_TOO_LATE");
    precachestring(&"SCRIPT_PLATFORM_DOG_DEATH_TOO_SOON");
    precachestring(&"SCRIPT_PLATFORM_DOG_HINT");
    precachestring(&"NEW_DOG_DEATH_DO_NOTHING_ALT");
    precachestring(&"NEW_DOG_DEATH_TOO_LATE_ALT");
    precachestring(&"NEW_DOG_DEATH_TOO_SOON_ALT");
  }

  if(isDefined(anim._id_3AF4)) {
    return;
  }
  precacheshader("hud_dog_melee");
  precacheshader("hud_hyena_melee");
  anim._id_3AF4 = 1;
  anim._id_3AEE = lengthsquared(getmovedelta( % german_shepherd_run_stop, 0, 1) * 1.2);
  anim._id_3AF5 = length(getmovedelta( % german_shepherd_run_start, 0, 1));
  anim._id_3AF0 = 102;
  var_0 = getstartorigin((0, 0, 0), (0, 0, 0), % german_shepherd_attack_ai_01_start_a);
  anim._id_3AF1 = length(var_0);
  anim._id_3AF6 = [];
  anim._id_3AF6["wallhop"] = % german_shepherd_run_jump_40;
  anim._id_3AF6["window_40"] = % german_shepherd_run_jump_window_40;
  anim._id_3AF6["jump_down_40"] = % german_shepherd_traverse_down_40;
  anim._id_3AF6["jump_up_40"] = % german_shepherd_traverse_up_40;
  anim._id_3AF6["jump_up_80"] = % german_shepherd_traverse_up_80;
  anim._id_3AF7[8] = 0;
  anim._id_3AF7[6] = 90;
  anim._id_3AF7[4] = -90;
  anim._id_3AF7[3] = 180;
  anim._id_3AF7[1] = -180;
  anim._id_3AF8[8] = % german_shepherd_run_start;
  anim._id_3AF8[6] = % german_shepherd_run_start_l;
  anim._id_3AF8[4] = % german_shepherd_run_start_r;
  anim._id_3AF8[3] = % german_shepherd_run_start_180_l;
  anim._id_3AF8[1] = % german_shepherd_run_start_180_r;
  anim._id_3AF9["attackIdle"][2] = % german_shepherd_attack_look_down;
  anim._id_3AF9["attackIdle"][4] = % german_shepherd_attack_look_left;
  anim._id_3AF9["attackIdle"][6] = % german_shepherd_attack_look_right;
  anim._id_3AF9["attackIdle"][8] = % german_shepherd_attack_look_up;
  anim._id_3AF9["normal"][2] = % german_shepherd_look_down;
  anim._id_3AF9["normal"][4] = % german_shepherd_look_left;
  anim._id_3AF9["normal"][6] = % german_shepherd_look_right;
  anim._id_3AF9["normal"][8] = % german_shepherd_look_up;
  level._effect["dog_bite_blood"] = loadfx("impacts/deathfx_dogbite");
  level._effect["deathfx_bloodpool"] = loadfx("impacts/deathfx_bloodpool_view");
  var_1 = 5;
  var_2 = [];

  for(var_3 = 0; var_3 <= var_1; var_3++) {
    var_2[var_2.size] = var_3 / var_1;

  }
  level._id_3AFA = 0;
  level._id_3AFB = maps\_utility::_id_0B53(var_2);
  setdvar("friendlySaveFromDog", "0");
}