/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_43e930c786cc935.csc
***********************************************/

#using script_18910f59cc847b42;
#using script_245f38df21b701ca;
#using script_30c7fb449869910;
#using script_30efbc1e0156ebae;
#using script_3314b730521b9666;
#using script_38635d174016f682;
#using script_41540e991952b0c1;
#using script_42cbbdcd1e160063;
#using script_4adf64e112e9afec;
#using script_60a2f38d6d37fd6a;
#using script_64e5d3ad71ce8140;
#using script_67049b48b589d81;
#using script_6b71c9befed901f2;
#using script_71603a58e2da0698;
#using script_75c3996cce8959f7;
#using script_75e0a2c8a5c12652;
#using script_76abb7986de59601;
#using script_77163d5a569e2071;
#using script_771f5bff431d8d57;
#using script_7bf1bd99605135bf;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_268747c0;

function init() {
  clientfield::register("scriptmover", "dragonTrapState", 1, 2, "int", &dragontrapstate, 0, 0);
  function_32d5e898();
}

function function_32d5e898(localclientnum) {}

function function_79445831() {
  self notify("18d073f66f509708");
  self endon("18d073f66f509708");
  fakemodel = self.fakemodel;
  self waittill(#"death");

  if(isDefined(fakemodel)) {
    fakemodel delete();
  }
}

function function_6f3ad355(localclientnum) {
  if(isDefined(self.fakemodel)) {
    self.fakemodel delete();
  }

  namespace_1e25ad94::debugmsg("Initializing dragonhead trap (" + self getentitynumber() + ") at origin:" + self.origin);
  self.fakemodel = spawn(localclientnum, self.origin, "script_model");
  self.fakemodel setModel("zombietron_dragonhead_trap");
  self.fakemodel.angles = self.angles;
  self thread function_79445831();
}

function dragontrapstate(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (bwastimejump) {
    case 0:
      if(isDefined(self.fakemodel)) {
        self.fakemodel delete();
      }

      namespace_1e25ad94::debugmsg("Destroying dragonhead trap (" + self getentitynumber() + ") at origin:" + self.origin);
      break;
    case 1:
      self function_6f3ad355(fieldname);
      break;
    case 2:
      if(!isDefined(self.fakemodel)) {
        self function_6f3ad355(fieldname);
      }

      assert(isDefined(self.fakemodel));
      self.fakemodel setModel("zombietron_dragonhead_trap");
      stopforcestreamingxmodel(#"zombietron_dragonhead_trap");
      forcestreamxmodel(#"zombietron_dragonhead_trap_active");
      namespace_1e25ad94::debugmsg("Setting dragonhead trap (" + self getentitynumber() + ") at origin:" + self.origin + " to model zombietron_dragonhead_trap");
      self.fakemodel thread namespace_83eb6304::function_8b1a4e9c(fieldname, "dragonTrap");
      break;
    case 3:
      if(!isDefined(self.fakemodel)) {
        self function_6f3ad355(fieldname);
      }

      assert(isDefined(self.fakemodel));
      self.fakemodel setModel("zombietron_dragonhead_trap_active");
      stopforcestreamingxmodel(#"zombietron_dragonhead_trap_active");
      forcestreamxmodel(#"zombietron_dragonhead_trap");
      namespace_1e25ad94::debugmsg("Setting dragonhead trap (" + self getentitynumber() + ") at origin:" + self.origin + " to model zombietron_dragonhead_trap_active");
      wait 1;

      if(isDefined(self.fakemodel)) {
        self.fakemodel thread namespace_83eb6304::function_f58618d7(fieldname, "dragonTrap", "tag_mouth_fx_anim");
      }

      break;
  }
}