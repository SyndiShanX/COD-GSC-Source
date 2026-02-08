/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\dog_init.gsc
**************************************/

#using_animtree("dog");

main() {
  self useAnimTree(#animtree);

  initDogAnimations();
  animscripts\init::firstInit();

  self.ignoreSuppression = true;

  self.chatInitialized = false;
  self.noDodgeMove = true;
  self.root_anim = % root;

  self.meleeAttackDist = 0;
  self thread setMeleeAttackDist();

  self.a = spawnStruct();
  self.a.pose = "stand";
  self.a.nextStandingHitDying = false;
  self.a.movement = "run";

  animscripts\init::set_anim_playback_rate();

  self.suppressionThreshold = 1;
  self.disableArrivals = false;
  self.stopAnimDistSq = anim.dogStoppingDistSq;

  self.pathEnemyFightDist = 512;
  self setTalkToSpecies("dog");

  self.health = int(anim.dog_health * self.health);
}

setMeleeAttackDist() {
  self endon("death");

  while(1) {
    if(isDefined(self.enemy) && isPlayer(self.enemy))
      self.meleeAttackDist = anim.dogAttackPlayerDist;
    else
      self.meleeAttackDist = anim.dogAttackAIDist;

    self waittill("enemy");
  }
}

initDogAnimations() {
  if(!isDefined(level.dogsInitialized)) {
    level.dogsInitialized = true;
    precachestring(&"SCRIPT_PLATFORM_DOG_DEATH_DO_NOTHING");
    precachestring(&"SCRIPT_PLATFORM_DOG_DEATH_TOO_LATE");
    precachestring(&"SCRIPT_PLATFORM_DOG_DEATH_TOO_SOON");
    precachestring(&"SCRIPT_PLATFORM_DOG_HINT");
  }

  if(isDefined(anim.NotFirstTimeDogs)) {
    return;
  }
  precacheShader("hud_dog_melee");
  anim.NotFirstTimeDogs = 1;
  anim.dogStoppingDistSq = lengthSquared(getmovedelta(%german_shepherd_run_stop, 0, 1) * 1.2);
  anim.dogStartMoveDist = length(getmovedelta(%german_shepherd_run_start, 0, 1));

  anim.dogAttackPlayerDist = 102;

  offset = getstartorigin((0, 0, 0), (0, 0, 0), %german_shepherd_attack_AI_01_start_a);
  anim.dogAttackAIDist = length(offset);

  anim.dogTraverseAnims = [];
  anim.dogTraverseAnims["wallhop"] = % german_shepherd_run_jump_40;
  anim.dogTraverseAnims["window_40"] = % german_shepherd_run_jump_window_40;
  anim.dogTraverseAnims["jump_down_40"] = % german_shepherd_traverse_down_40;
  anim.dogTraverseAnims["jump_up_40"] = % german_shepherd_traverse_up_40;
  anim.dogTraverseAnims["jump_up_80"] = % german_shepherd_traverse_up_80;

  anim.dogStartMoveAngles[8] = 0;
  anim.dogStartMoveAngles[6] = 90;
  anim.dogStartMoveAngles[4] = -90;
  anim.dogStartMoveAngles[3] = 180;
  anim.dogStartMoveAngles[1] = -180;

  anim.dogLookPose["attackIdle"][2] = % german_shepherd_attack_look_down;
  anim.dogLookPose["attackIdle"][4] = % german_shepherd_attack_look_left;
  anim.dogLookPose["attackIdle"][6] = % german_shepherd_attack_look_right;
  anim.dogLookPose["attackIdle"][8] = % german_shepherd_attack_look_up;

  anim.dogLookPose["normal"][2] = % german_shepherd_look_down;
  anim.dogLookPose["normal"][4] = % german_shepherd_look_left;
  anim.dogLookPose["normal"][6] = % german_shepherd_look_right;
  anim.dogLookPose["normal"][8] = % german_shepherd_look_up;

  level._effect["dog_bite_blood"] = loadfx("impacts/fx_deathfx_bloodpool_view");
  level._effect["deathfx_bloodpool"] = loadfx("impacts/fx_deathfx_dogbite");

  slices = 5;
  array = [];
  for(i = 0; i <= slices; i++) {
    array[array.size] = i / slices;
  }
  level.dog_melee_index = 0;
  level.dog_melee_timing_array = maps\_utility::array_randomize(array);

  level.lastDogMeleePlayerTime = 0;
  level.dogMeleePlayerCounter = 0;

  setDvar("friendlySaveFromDog", "0");
}