/****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\dog\dog_init.gsc
****************************************/

#using_animtree("dog");

main() {
  self useanimtree(#animtree);
  initdoganimations();
  animscripts\init::firstinit();
  self.ignoresuppression = 1;
  self.newenemyreactiondistsq = 0;
  self.chatinitialized = 0;
  self.nododgemove = 1;
  self.root_anim = % root;
  self.meleeattackdist = 0;
  thread setmeleeattackdist();
  self.a = spawnstruct();
  self.a.pose = "stand";
  self.a.nextstandinghitdying = 0;
  self.a.movement = "run";
  animscripts\init::set_anim_playback_rate();
  self.suppressionthreshold = 1;
  self.disablearrivals = 0;
  self.stopanimdistsq = anim.dogstoppingdistsq;
  self.usechokepoints = 0;
  self.turnrate = 0.2;
  thread animscripts\combat_utility::monitorflash();
  self.pathenemyfightdist = 512;
  self settalktospecies("dog");
  self.health = int(anim.dog_health * self.health);
}

setmeleeattackdist() {
  self endon("death");

  for (;;) {
    if(isdefined(self.enemy) && isplayer(self.enemy))
      self.meleeattackdist = anim.dogattackplayerdist;
    else
      self.meleeattackdist = anim.dogattackaidist;

    self waittill("enemy");
  }
}

initdoganimations() {
  if(!isdefined(level.dogsinitialized)) {
    level.dogsinitialized = 1;
    precachestring(&"SCRIPT_PLATFORM_DOG_DEATH_DO_NOTHING");
    precachestring(&"SCRIPT_PLATFORM_DOG_DEATH_TOO_LATE");
    precachestring(&"SCRIPT_PLATFORM_DOG_DEATH_TOO_SOON");
    precachestring(&"SCRIPT_PLATFORM_DOG_HINT");
    precachestring(&"SCRIPT_PLATFORM_DOG_HINT_KEYBOARD");
    precachestring(&"NEW_DOG_DEATH_DO_NOTHING_ALT");
    precachestring(&"NEW_DOG_DEATH_TOO_LATE_ALT");
    precachestring(&"NEW_DOG_DEATH_TOO_SOON_ALT");
  }

  if(isdefined(anim.notfirsttimedogs)) {
    return;
  }
  precacheshader("hud_dog_melee");
  precacheshader("h1_dog_melee_prompt_star");
  precacheshader("h1_hud_tutorial_blur");
  precacheshader("h1_hud_tutorial_border");
  anim.notfirsttimedogs = 1;
  anim.dogstoppingdistsq = lengthsquared(getmovedelta( % german_shepherd_run_stop, 0, 1) * 1.2);
  anim.dogstartmovedist = length(getmovedelta( % german_shepherd_run_start, 0, 1));
  anim.dogattackplayerdist = 102;
  var_0 = getstartorigin((0, 0, 0), (0, 0, 0), % german_shepherd_attack_ai_01_start_a);
  anim.dogattackaidist = length(var_0);
  anim.dogtraverseanims = [];
  anim.dogtraverseanims["wallhop"] = % german_shepherd_run_jump_40;
  anim.dogtraverseanims["window_40"] = % german_shepherd_run_jump_window_40;
  anim.dogtraverseanims["jump_down_40"] = % german_shepherd_traverse_down_40;
  anim.dogtraverseanims["jump_up_40"] = % german_shepherd_traverse_up_40;
  anim.dogtraverseanims["jump_up_80"] = % german_shepherd_traverse_up_80;
  anim.dogstartmoveangles[8] = 0;
  anim.dogstartmoveangles[6] = 90;
  anim.dogstartmoveangles[4] = -90;
  anim.dogstartmoveangles[3] = 180;
  anim.dogstartmoveangles[1] = -180;
  anim.dogstartmoveanim[8] = % german_shepherd_run_start;
  anim.dogstartmoveanim[6] = % german_shepherd_run_start_l;
  anim.dogstartmoveanim[4] = % german_shepherd_run_start_r;
  anim.dogstartmoveanim[3] = % german_shepherd_run_start_180_l;
  anim.dogstartmoveanim[1] = % german_shepherd_run_start_180_r;
  anim.doglookpose["attackIdle"][2] = % german_shepherd_attack_look_down;
  anim.doglookpose["attackIdle"][4] = % german_shepherd_attack_look_left;
  anim.doglookpose["attackIdle"][6] = % german_shepherd_attack_look_right;
  anim.doglookpose["attackIdle"][8] = % german_shepherd_attack_look_up;
  anim.doglookpose["normal"][2] = % german_shepherd_look_down;
  anim.doglookpose["normal"][4] = % german_shepherd_look_left;
  anim.doglookpose["normal"][6] = % german_shepherd_look_right;
  anim.doglookpose["normal"][8] = % german_shepherd_look_up;
  level._effect["dog_bite_blood"] = loadfx("impacts\deathfx_dogbite");
  level._effect["deathfx_bloodpool"] = loadfx("impacts\deathfx_bloodpool_view");
  var_1 = 5;
  var_2 = [];

  for (var_3 = 0; var_3 <= var_1; var_3++)
    var_2[var_2.size] = var_3 / var_1;

  level.dog_melee_index = 0;
  level.dog_melee_timing_array = common_scripts\utility::array_randomize(var_2);
  setdvar("friendlySaveFromDog", "0");
}