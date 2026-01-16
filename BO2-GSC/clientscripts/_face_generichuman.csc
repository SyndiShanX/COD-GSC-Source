/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_face_generichuman.csc
************************************************/

#include clientscripts\_face_utility;
#include clientscripts\_face_generichuman;

init() {
  level._facecbfunc_generichuman = clientscripts\_face_generichuman::doface_generichuman;
}

#using_animtree("generic_human");

buildcasualfaceanims() {
  animlist = array( % f_idle_casual_v1, % f_idle_casual_v2, % f_idle_casual_v3);
  self buildfacestate("face_casual", 1, -1, 0, "basestate", animlist);
}

buildalertfaceanims() {
  animlist = array( % f_idle_alert_v2, % f_idle_alert_v4, % f_idle_alert_v6, % f_idle_alert_v8, % f_idle_alert_v9, % f_idle_alert_v10);
  self buildfacestate("face_alert", 1, -1, 0, "basestate", animlist);
}

buildcqbfaceanims() {
  animlist = array( % f_idle_alert_v1, % f_idle_alert_v4);
  self buildfacestate("face_cqb", 1, -1, 0, "basestate", animlist);
}

buildrunninganims() {
  animlist = array( % f_running_v1, % f_running_v2);
  self buildfacestate("face_running", 1, -1, 0, "basestate", animlist);
}

buildsinglefirefaceanims() {
  animlist = array( % f_firing_v8, % f_firing_v10, % f_firing_v11, % f_firing_v13, % f_firing_v14);
  self buildfacestate("face_shoot_single", 0, 1, 1, "eventstate", animlist);
}

buildburstfirefaceanims() {
  animlist = array( % f_firing_v2, % f_firing_v3, % f_firing_v7, % f_firing_v9, % f_firing_v12);
  self buildfacestate("face_shoot_burst", 1, 1, 1, "eventstate", animlist);
}

buildmeleefaceanims() {
  animlist = array( % f_melee_v1, % f_melee_v2, % f_melee_v3, % f_melee_v4, % f_melee_v5, % f_melee_v6, % f_melee_v7, % f_melee_v8);
  self buildfacestate("face_melee", 1, 2, 1, "eventstate", animlist);
}

buildtalkanims() {
  animlist = array( % f_im_reloading);
  self buildfacestate("face_talk", 1, 0.1, 2, "eventstate", animlist);
}

buildreactanims() {
  animlist = array( % f_react_v3, % f_react_v4, % f_react_v6);
  self buildfacestate("face_react", 0, -1, 2, "eventstate", animlist);
}

buildpainfaceanims() {
  animlist = array( % f_pain_v1, % f_pain_v2, % f_pain_v4, % f_pain_v5, % f_pain_v6, % f_pain_v7);
  self buildfacestate("face_pain", 0, -1, 3, "eventstate", animlist);
}

builddeathfaceanims() {
  animlist = array( % f_death_v1, % f_death_v2, % f_death_v3, % f_death_v4, % f_death_v5, % f_death_v6, % f_death_v7, % f_death_v8);
  self buildfacestate("face_death", 0, -1, 4, "exitstate", animlist);
}

doface_generichuman(localclientnum) {
  if(self.species != "human") {
    return;
  }
  if(!isDefined(self.face_disable))
    self.face_disable = 0;

  if(!isDefined(self.face_death))
    self.face_death = 0;

  self.face_anim_tree = "generic_human";

  if(!isDefined(level.facestates))
    level.facestates = [];

  if(!isDefined(level.facestates[self.face_anim_tree])) {
    self setfaceroot( % faces);
    self buildcasualfaceanims();
    self buildalertfaceanims();
    self buildcqbfaceanims();
    self buildsinglefirefaceanims();
    self buildburstfirefaceanims();
    self buildmeleefaceanims();
    self buildpainfaceanims();
    self builddeathfaceanims();
    self buildtalkanims();
    self buildreactanims();
    self buildrunninganims();
    self buildfacestate("face_advance", 0, -1, 4, "nullstate", undefined);
  }

  self thread processfaceevents(localclientnum);
}