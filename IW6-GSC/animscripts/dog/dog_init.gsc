/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\dog\dog_init.gsc
****************************************/

#using_animtree("dog");

main() {
  if(isDefined(level.shark_functions)) {
    if(issubstr(self.model, "shark")) {
      self[[level.shark_functions["init"]]]();
      return;
    }
  }

  self useanimtree(#animtree);
  initdoganimations();
  initdogarchetype();
  animscripts\init::firstinit();
  self.ignoresuppression = 1;
  self.newenemyreactiondistsq = 0;
  self.chatinitialized = 0;
  self.nododgemove = 1;
  self.root_anim = % body;
  self.meleeattackdist = 0;
  thread setmeleeattackdist();
  self.a = spawnStruct();
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

  if(!level.console)
    thread pc_dogsetup();
}

pc_upgradedog() {
  var_0 = issubstr(self.model, "dog");

  if(var_0)
    var_1 = "dog";
  else
    var_1 = "wolf";

  var_2 = maps\_utility_dogs::get_dog_model_letter_type(self.model);

  if(!isDefined(level.furfx) || !isDefined(level.furfx[var_1]) || !isDefined(level.furfx[var_1][var_2])) {
    return;
  }
  self endon("death");
  self setModel(self.model + "_fur");
  wait 0.25;
  self.furfx = level.furfx[var_1][var_2];
  playFXOnTag(self.furfx, self, "tag_origin");
}

pc_downgradedog() {
  if(!issubstr(self.model, "_fur")) {
    return;
  }
  var_0 = getsubstr(self.model, 0, self.model.size - 4);
  var_1 = issubstr(self.model, "dog");

  if(var_1)
    var_2 = "dog";
  else
    var_2 = "wolf";

  if(isDefined(self.furfx)) {
    killfxontag(self.furfx, self, "tag_origin");
    self.furfx = undefined;
  }

  self setModel(var_0);
}

pc_dogsetup() {
  if(ishairrunning())
    pc_upgradedog();

  if(!isDefined(self.pc_furmonitor)) {
    self.pc_furmonitor = 1;
    thread pc_furmonitor();
  }
}

pc_furmonitor() {
  self endon("death");
  var_0 = ishairrunning();

  for(;;) {
    wait 0.1;
    var_1 = ishairrunning();

    if(var_0 != var_1) {
      if(var_1)
        pc_upgradedog();
      else
        pc_downgradedog();
    }

    var_0 = var_1;
  }
}

setmeleeattackdist() {
  self endon("death");

  for(;;) {
    if(isDefined(self.enemy) && isPlayer(self.enemy))
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
    precachestring(&"NEW_DOG_DEATH_DO_NOTHING_ALT");
    precachestring(&"NEW_DOG_DEATH_TOO_LATE_ALT");
    precachestring(&"NEW_DOG_DEATH_TOO_SOON_ALT");
  }

  if(isDefined(anim.notfirsttimedogs)) {
    return;
  }
  precacheshader("hud_dog_melee");
  precacheshader("hud_hyena_melee");
  anim.notfirsttimedogs = 1;
  anim.dogstoppingdistsq = lengthsquared(getmovedelta(%iw6_dog_attackidle_runin_8, 0, 1) * 3);
  anim.dogstartmovedist = length(getmovedelta(%iw6_dog_attackidle_runout_8, 0, 1));
  anim.dogattackplayerdist = 102;
  var_0 = getstartorigin((0, 0, 0), (0, 0, 0), %iw6_dog_kill_front_quick_1);
  anim.dogattackaidist = length(var_0);
  anim.dogtraverseanims = [];
  anim.dogtraverseanims["wallhop"] = % iw6_dog_traverse_over_24;
  anim.dogtraverseanims["window_40"] = % iw6_dog_traverse_over_36;
  anim.dogtraverseanims["jump_down_40"] = % iw6_dog_traverse_down_40;
  anim.dogtraverseanims["jump_down_24"] = % iw6_dog_traverse_down_24;
  anim.dogtraverseanims["jump_up_24"] = % iw6_dog_traverse_up_24;
  anim.dogtraverseanims["jump_up_40"] = % iw6_dog_traverse_up_40;
  anim.dogtraverseanims["jump_up_80"] = % iw6_dog_traverse_up_70;
  anim.dogtraverseanims["jump_down_70"] = % iw6_dog_traverse_down_70;
  anim.doglookpose["attackIdle"][2] = % german_shepherd_attack_look_down;
  anim.doglookpose["attackIdle"][4] = % german_shepherd_attack_look_left;
  anim.doglookpose["attackIdle"][6] = % german_shepherd_attack_look_right;
  anim.doglookpose["attackIdle"][8] = % german_shepherd_attack_look_up;
  anim.doglookpose["normal"][2] = % german_shepherd_look_down;
  anim.doglookpose["normal"][4] = % german_shepherd_look_left;
  anim.doglookpose["normal"][6] = % german_shepherd_look_right;
  anim.doglookpose["normal"][8] = % german_shepherd_look_up;
  level._effect["dog_bite_blood"] = loadfx("fx/impacts/deathfx_dogbite");
  level._effect["deathfx_bloodpool"] = loadfx("fx/impacts/deathfx_bloodpool_view");
  var_1 = 5;
  var_2 = [];

  for(var_3 = 0; var_3 <= var_1; var_3++)
    var_2[var_2.size] = var_3 / var_1;

  level.dog_melee_index = 0;
  level.dog_melee_timing_array = common_scripts\utility::array_randomize(var_2);
  setDvar("friendlySaveFromDog", "0");
}

initdogarchetype() {
  animscripts\animset::init_anim_sets();

  if(animscripts\animset::archetypeexists("dog")) {
    return;
  }
  anim.archetypes["dog"] = [];
  animscripts\dog\dog_stop::initdogarchetype_stop();
  animscripts\dog\dog_move::initdogarchetype_move();
  animscripts\dog\dog_pain::initdogarchetype_reaction();
  animscripts\dog\dog_death::initdogarchetype_death();
}