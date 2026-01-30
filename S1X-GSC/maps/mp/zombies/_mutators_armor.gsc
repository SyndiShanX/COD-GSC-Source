/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\_mutators_armor.gsc
***********************************************/

initarmormutator() {
  level.valideyetypes[level.valideyetypes.size] = "armored";
  level._effect["mut_helmet_impact"] = loadfx("vfx/explosion/impact_sparks_01");
  maps\mp\gametypes\zombies::loadeyeeffectsfortype("armored", 1);
  maps\mp\zombies\_mutators::addmutatortotable("armor", ::mutatorarmor, "zmb_mut_armor_spawn", undefined, ::onhelmetzombiedamaged);
  maps\mp\zombies\_mutators::disablemutatorfortypes("armor", ["zombie_dog", "zombie_melee_goliath", "zombie_ranged_goliath"]);
}

mutatorarmor() {
  thread maps\mp\zombies\_mutators::mutatorspawnsound("armor");
  maps\mp\agents\humanoid\_humanoid_util::enable_humanoid_exo_abilities();
  self.boostfxtag = "no_boost_fx";
  var_0 = "J_helmet";
  self.hasarmor = 1;
  self.hashelmet = 1;
  self detachall();
  self.limbmodels = undefined;
  self.helmet_health = 50;
  self setModel("zom_mut_armor_body");
  var_1 = ["zombies_head_mutator_fire", "zombies_head_mutator_fire_cau_a", "zombies_head_mutator_fire_cau_b", "zombies_head_mutator_fire_cau_c"];
  var_2 = randomint(var_1.size);
  self attach(var_1[var_2]);
  self.headmodel = var_1[var_2];
  var_3 = maps\mp\gametypes\zombies::geteyeeffectforzombie("armored", self.headmodel);
  maps\mp\zombies\_util::zombie_set_eyes(var_3);

  if(!isDefined(self.moverateroundmod)) {
    self.moverateroundmod = 0;
  }

  self.moverateroundmod = self.moverateroundmod + 0.85;
  var_4 = self gettagorigin(var_0);
  var_5 = self gettagangles(var_0);
  var_6 = spawn("script_model", var_4);
  var_6.angles = var_5;
  var_6 setModel("zombie_helmet");
  var_6 linkto(self, var_0, (-0.2, -0.45, -4.7), (0, 90, 0));
  thread mutatorhelmetdetach(var_6);
  self waittill("death");
  self.hashelmet = undefined;
  thread mutatorhelmetcleanup(var_6);
}

onhelmetzombiedamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(self.hashelmet) && isplayer(var_1) && maps\mp\_utility::isheadshot(var_5, var_8, var_4)) {
    self.helmet_health = self.helmet_health - var_2;

    if(self.helmet_health <= 0) {
      self notify("helmet_lost");
    }
  }
}

mutatorhelmetdetach(var_0) {
  self endon("death");
  self waittill("helmet_lost");
  self.hashelmet = undefined;
  earthquake(0.25, 0.4, self.origin, 128);
  self.moverateroundmod = self.moverateroundmod + 5;
  playFX(common_scripts\utility::getfx("mut_helmet_impact"), var_0.origin);
  var_0 playSound("zmb_mut_armor_helmet_ping");
  var_0 unlink();
  var_0 setModel("zombie_helmet_collision");
  var_0 physicslaunchclient(var_0.origin, (randomintrange(-5, 5), randomintrange(-5, 5), randomintrange(-5, 5)));
  physicsexplosionsphere(var_0.origin - (0, 0, 2), 16, 1, 5);
  thread mutatorhelmetcleanup(var_0);
}

mutatorhelmetcleanup(var_0) {
  wait 5;

  if(isDefined(var_0)) {
    var_0 delete();
  }
}