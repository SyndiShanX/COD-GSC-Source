/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_694bbdce9542b4b5.gsc
*****************************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\engine\utility;
#namespace visionsets;

function autoexec preinit() {
  if(function_9c44e6874f16932e(1)) {
    return;
  }

  level callback::add(#"register_fullscreenfx", &function_b296177ad02da9eb);

  if(!isDefined(level.fullscreenfx)) {
    level.fullscreenfx = spawnStruct();
  }
}

function function_b296177ad02da9eb(params) {
  fullscreenfxtechnique = level.gamemodebundle.fullscreenfxtechnique ?? #"visionset";

  if(level.gamemodebundle.fullscreenfxtechnique != #"visionset") {
    return;
  }

  utility::registersharedfunc(#"fullscreenfx", #"setpain", &setpain);
  utility::registersharedfunc(#"fullscreenfx", #"setdeath", &setdeath);
  utility::registersharedfunc(#"fullscreenfx", #"hash_f7bfc77c8b6be6e5", &function_d83fe9a0e16b868);
  utility::registersharedfunc(#"fullscreenfx", #"hash_702fe2dff06ac055", &function_a6072b9012c3e950);
  utility::registersharedfunc(#"fullscreenfx", #"hash_967b2afe3d37405", &function_270ab7977ed0dcd0);
  utility::registersharedfunc(#"fullscreenfx", #"senddamageevent", &senddamageevent);
  utility::registersharedfunc(#"fullscreenfx", #"hash_d6d2b1e7868b8f30", &function_e5ca24b8ebd3094d);
  utility::registersharedfunc(#"fullscreenfx", #"hash_fd9af8d6ec7cc6fb", &function_af953127cb592712);
  level.var_5d5a8dba0f6b0275 = level.gamemodebundle.fullscreenfxtechnique;
}

function setpain(params) {
  if(isDefined(params.visionsetname)) {
    if(isDefined(params.transitiontime)) {
      visionsetpain(params.visionsetname, params.transitiontime);
      return;
    }

    visionsetpain(params.visionsetname);
  }
}

function setdeath(params) {
  if(isDefined(params.visionsetname)) {
    visionsetdeath(params.visionsetname);
  }
}

function function_d83fe9a0e16b868(params) {
  if(isDefined(params.visionsetname)) {
    function_62843dbefc74e4dc(params.visionsetname);
  }
}

function function_a6072b9012c3e950(params) {
  if(isDefined(params.visionsetname)) {
    function_16911d9daf8264e4(params.visionsetname);
  }
}

function function_270ab7977ed0dcd0() {
  if(isDefined(level.var_72224543c35d911c)) {
    deathvision = level.var_72224543c35d911c;
  } else {
    deathvision = level.gamemodebundle.visionset_death ?? "\x1e\xfd\xd1\xa2\a";
  }

  setpain({
    #visionsetname: level.gamemodebundle.visionset_pain
  });
  setdeath({
    #visionsetname: deathvision
  });
  function_d83fe9a0e16b868({
    #visionsetname: level.gamemodebundle.var_31b2bd18088ff3c5 ?? "@<\x8d\xef\xea\x17B\xb9|\a\xc6\x83\b"});
  function_a6072b9012c3e950({
    #visionsetname: level.gamemodebundle.var_8ed4bbc9dd4a538b ?? "\x98\xc6\xc7\x17o\xc5\xc81\xee}\xe5YF"});
}

function senddamageevent(damageevent) {
  damageevent.player function_195618089d0b7772(damageevent.eventtype);
  damageevent.player function_524c3027d2b3b392(damageevent.eventtype);
}

function function_e5ca24b8ebd3094d(params) {
  if(isDefined(params.visionsetname)) {
    namespace_bc7cdace2d7445a5::function_bfe8df8d71fb2e33(params.visionsetname);
    self.currentvisionset = params.visionsetname;
  }
}

function function_af953127cb592712(params) {
  namespace_bc7cdace2d7445a5::function_bfe8df8d71fb2e33("");
  self.currentvisionset = undefined;
}