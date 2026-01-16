/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\dog_init.gsc
**************************************/

#include common_scripts\utility;
#include animscripts\init;
#include animscripts\utility;
#include animscripts\shared;
#using_animtree("dog");

main() {
  self useanimtree(#animtree);
  initdoganimations();
  animscripts\init::firstinit();
  animscripts\utility::setcurrentweapon(self.weapon);
  self.ignoresuppression = 1;
  self.chatinitialized = 0;
  self.nododgemove = 1;
  self.root_anim = % root;
  self.meleeattackdist = 0;
  self thread setmeleeattackdist();
  self.a = spawnstruct();
  self.a.pose = "stand";
  self.a.nextstandinghitdying = 0;
  self.a.movement = "run";
  animscripts\init::set_anim_playback_rate();
  self.suppressionthreshold = 1;
  self.disablearrivals = 0;
  self.stopanimdistsq = anim.dogstoppingdistsq;
  self.pathenemyfightdist = 512;
  self settalktospecies("dog");
  self.health = int(anim.dog_health * self.health);
  self thread animscripts\shared::trackloop();
}

setmeleeattackdist() {
  self endon("death");

  while(true) {
    if(isDefined(self.enemy) && isplayer(self.enemy))
      self.meleeattackdist = anim.dogattackplayerdist;
    else
      self.meleeattackdist = anim.dogattackaidist;

    self waittill("enemy");
  }
}

initdoganimations() {
  if(!isDefined(level.dogsinitialized)) {
    level.dogsinitialized = 1;
    precachestring(&"SCRIPT_PLATFORM_DOG_DEATH_DO_NOTHING");
    precachestring(&"SCRIPT_PLATFORM_DOG_DEATH_TOO_LATE");
    precachestring(&"SCRIPT_PLATFORM_DOG_DEATH_TOO_SOON");
    precachestring(&"SCRIPT_PLATFORM_DOG_HINT");
  }

  if(isDefined(anim.notfirsttimedogs)) {
    return;
  }
  precacheshader("hud_dog_melee");
  anim.notfirsttimedogs = 1;
  anim.dogstoppingdistsq = lengthsquared(getmovedelta( % german_shepherd_run_stop, 0, 1) * 1.2);
  anim.dogstartmovedist = length(getmovedelta( % german_shepherd_run_start, 0, 1));
  anim.dogattackplayerdist = 102;
  offset = getstartorigin((0, 0, 0), (0, 0, 0), % german_shepherd_attack_ai_01_start_a);
  anim.dogattackaidist = length(offset);
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
  anim.doglookpose["attackIdle"][2] = % german_shepherd_attack_look_down;
  anim.doglookpose["attackIdle"][4] = % german_shepherd_attack_look_left;
  anim.doglookpose["attackIdle"][6] = % german_shepherd_attack_look_right;
  anim.doglookpose["attackIdle"][8] = % german_shepherd_attack_look_up;
  anim.doglookpose["normal"][2] = % german_shepherd_look_down;
  anim.doglookpose["normal"][4] = % german_shepherd_look_left;
  anim.doglookpose["normal"][6] = % german_shepherd_look_right;
  anim.doglookpose["normal"][8] = % german_shepherd_look_up;
  level._effect["dog_bite_blood"] = loadfx("impacts/fx_deathfx_bloodpool_view");
  level._effect["deathfx_bloodpool"] = loadfx("impacts/fx_deathfx_dogbite");
  level._effect["dog_rip_throat"] = loadfx("misc/fx_dog_rip_throat");
  array = [];

  for(i = 0; i <= 5; i++)
    array[array.size] = i / 5;

  level.dog_melee_index = 0;
  level.dog_melee_timing_array = array_randomize(array);
  level.lastdogmeleeplayertime = 0;
  level.dogmeleeplayercounter = 0;
  setdvar("friendlySaveFromDog", "0");
}