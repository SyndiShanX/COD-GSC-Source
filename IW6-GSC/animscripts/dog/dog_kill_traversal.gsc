/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\dog\dog_kill_traversal.gsc
**************************************************/

check_kill_traversal(var_0) {
  if(self.team != "allies")
    return 0;

  self endon("killanimscript");
  var_1 = self getnegotiationstartnode();
  var_2 = self getnegotiationendnode();
  var_3 = getaiarray("axis");
  var_4 = undefined;
  var_5 = dog_get_within_range(var_2.origin, var_3, 90);

  if(var_5.size > 0) {
    var_6 = var_5[0];
    var_7 = lengthsquared(var_1.origin - var_2.origin);
    var_8 = lengthsquared(var_1.origin - var_6.origin);

    if(var_8 < var_7) {
      self.syncedmeleetarget2 = var_6;
      var_6.syncedmeleetarget2 = self;
      var_6.traversedata = var_0;
      var_9 = [];
      var_9[0][0] = 400;
      var_9[0][1] = "blood_small";
      var_9[0][2] = "J_Neck";
      var_9[1][0] = 2300;
      var_9[1][1] = "blood_medium";
      var_9[1][2] = "J_Neck";
      var_9[2][0] = 2600;
      var_9[2][1] = "blood_medium";
      var_9[2][2] = "J_Neck";
      var_9[3][0] = 3300;
      var_9[3][1] = "blood_heavy";
      var_9[3][2] = "J_Neck";
      var_6 thread monitorfx(var_9);
      var_6 animcustom(::human_traverse_kill);
      self orientmode("face angle", var_1.angles[1]);
      dog_traverse_kill(var_0);
      return 1;
    }
  }

  return 0;
}

dog_get_within_range(var_0, var_1, var_2) {
  var_3 = [];

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(distance(var_1[var_4].origin, var_0) <= var_2)
      var_3[var_3.size] = var_1[var_4];
  }

  return var_3;
}

#using_animtree("dog");

dog_traverse_kill(var_0) {
  self.safetochangescript = 0;
  self.orig_flashbangimmunity = self.flashbangimmunity;
  self.flashbangimmunity = 1;
  self.pushable = 0;
  self traversemode("nogravity");
  self traversemode("noclip");
  self clearpitchorient();
  self setCanDamage(0);
  self clearanim(%body, 0.1);
  self setflaggedanimrestart("dog_traverse", level.scr_anim["generic"][var_0["traverseAnim"]][0], 1, 0.2, 1);
  animscripts\shared::donotetracks("dog_traverse");
  self unlink();
  self setCanDamage(1);
  self traversemode("gravity");
  self.pushable = 1;
  self.safetochangescript = 1;
  self.flashbangimmunity = self.orig_flashbangimmunity;
}

#using_animtree("generic_human");

human_traverse_kill() {
  self endon("killanimscript");
  self endon("death");
  self orientmode("face point", self.syncedmeleetarget2.origin, 1);
  self animmode("nogravity");
  self.a.pose = "stand";
  self.a.special = "none";

  if(animscripts\utility::usingsidearm())
    animscripts\shared::placeweaponon(self.primaryweapon, "right");

  self clearanim(%body, 0.1);
  self setflaggedanimrestart("aianim", level.scr_anim["generic"][self.traversedata["traverseAnim"]][1], 1, 0.1, 1);

  if(isDefined(self.traversedata["linkMe"]))
    thread dog_link();

  animscripts\shared::donotetracks("aianim");
  self waittillmatch("aianim", "end");

  if(isalive(self) && !isDefined(self.magic_bullet_shield)) {
    self.a.nodeath = 1;
    animscripts\shared::dropallaiweapons();
    self kill();
  }
}

monitorfx(var_0) {
  self endon("death");
  var_1 = 0;
  var_2 = gettime();

  while(var_1 < var_0.size) {
    var_3 = gettime() - var_2;

    if(var_3 >= var_0[var_1][0]) {
      playFXOnTag(level._effect[var_0[var_1][1]], self, var_0[var_1][2]);
      var_1++;
    }

    wait 0.05;
  }
}

dog_link() {
  wait 0.15;
  self.syncedmeleetarget2 linkto(self, "tag_sync", (0, 0, 0), (0, 0, 0));
}