/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\dog\dog_death.gsc
*****************************************/

#using_animtree("dog");

main() {
  if(isDefined(level.shark_functions)) {
    if(issubstr(self.model, "shark")) {
      self[[level.shark_functions["death"]]]();
      return;
    }
  }

  self endon("killanimscript");

  if(isDefined(self.a.nodeath)) {
    wait 1.1;
    var_0 = self getdroptofloorposition();

    if(isDefined(var_0)) {
      var_1 = common_scripts\utility::spawn_tag_origin();
      var_1.origin = self.origin;
      var_1.angles = self.angles;
      self linkto(var_1);
      var_1 moveto(var_0, 0.5);
      wait 0.5;
      self unlink();
      var_1 delete();
    } else
      wait 0.5;

    return;
  }

  self unlink();

  if(isDefined(self.enemy) && isDefined(self.enemy.syncedmeleetarget) && self.enemy.syncedmeleetarget == self) {
    self.enemy.syncedmeleetarget = undefined;
  }

  self clearanim( % body, 0.2);
  var_2 = getdogdeathanim("front");

  if(isDefined(self.deathanim)) {
    var_2 = self.deathanim;
  }

  if(isDefined(self.custom_deathsound)) {
    self playSound(self.custom_deathsound);
  }
  else if(self isdogbeingdriven()) {
    self playSound("anml_dog_shot_death_plr");
  }
  else {
    self playSound("anml_dog_shot_death");
  }

  self setflaggedanimrestart("dog_anim", var_2, 1, 0.2, 1);
  animscripts\shared::donotetracks("dog_anim");
}

getdogdeathanim(var_0) {
  var_1 = animscripts\utility::lookupdoganim("death", var_0);

  if(isarray(var_1)) {
    return var_1[randomint(var_1.size)];
  }

  return var_1;
}

initdogarchetype_death() {
  var_0 = [];
  var_0["front"] = [ % iw6_dog_death_4, % iw6_dog_death_6];
  anim.archetypes["dog"]["death"] = var_0;
}