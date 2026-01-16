/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\postfx_shared.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\duplicaterenderbundle;
#using scripts\shared\filter_shared;
#using scripts\shared\gfx_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace postfx;

function autoexec __init__sytem__() {
  system::register("postfx_bundle", & __init__, undefined, undefined);
}

function __init__() {
  callback::on_localplayer_spawned( & localplayer_postfx_bundle_init);
}

function localplayer_postfx_bundle_init(localclientnum) {
  init_postfx_bundles();
}

function init_postfx_bundles() {
  if(isdefined(self.postfxbundelsinited)) {
    return;
  }
  self.postfxbundelsinited = 1;
  self.playingpostfxbundle = "";
  self.forcestoppostfxbundle = 0;
  self.exitpostfxbundle = 0;
  self thread postfxbundledebuglisten();
}

function postfxbundledebuglisten() {
  self endon("entityshutdown");
  setdvar("", "");
  setdvar("", "");
  setdvar("", "");
  while (true) {
    playbundlename = getdvarstring("");
    if(playbundlename != "") {
      self thread playpostfxbundle(playbundlename);
      setdvar("", "");
    }
    stopbundlename = getdvarstring("");
    if(stopbundlename != "") {
      self thread stoppostfxbundle();
      setdvar("", "");
    }
    stopbundlename = getdvarstring("");
    if(stopbundlename != "") {
      self thread exitpostfxbundle();
      setdvar("", "");
    }
    wait(0.5);
  }
}

function playpostfxbundle(playbundlename) {
  self endon("entityshutdown");
  self endon("death");
  init_postfx_bundles();
  stopplayingpostfxbundle();
  bundle = struct::get_script_bundle("postfxbundle", playbundlename);
  if(!isdefined(bundle)) {
    println(("" + playbundlename) + "");
    return;
  }
  filterid = 0;
  totalaccumtime = 0;
  filter::init_filter_indices();
  self.playingpostfxbundle = playbundlename;
  localclientnum = self.localclientnum;
  looping = 0;
  enterstage = 0;
  exitstage = 0;
  finishlooponexit = 0;
  firstpersononly = 0;
  if(isdefined(bundle.looping)) {
    looping = bundle.looping;
  }
  if(isdefined(bundle.enterstage)) {
    enterstage = bundle.enterstage;
  }
  if(isdefined(bundle.exitstage)) {
    exitstage = bundle.exitstage;
  }
  if(isdefined(bundle.finishlooponexit)) {
    finishlooponexit = bundle.finishlooponexit;
  }
  if(isdefined(bundle.firstpersononly)) {
    firstpersononly = bundle.firstpersononly;
  }
  if(looping) {
    num_stages = 1;
    if(enterstage) {
      num_stages++;
    }
    if(exitstage) {
      num_stages++;
    }
  } else {
    num_stages = bundle.num_stages;
  }
  self.captureimagename = undefined;
  if(isdefined(bundle.screencapture) && bundle.screencapture) {
    self.captureimagename = playbundlename;
    createscenecodeimage(localclientnum, self.captureimagename);
    captureframe(localclientnum, self.captureimagename);
    setfilterpasscodetexture(localclientnum, filterid, 0, 0, self.captureimagename);
  }
  self thread watchentityshutdown(localclientnum, filterid);
  for (stageidx = 0; stageidx < num_stages && !self.forcestoppostfxbundle; stageidx++) {
    stageprefix = "s";
    if(stageidx < 10) {
      stageprefix = stageprefix + "0";
    }
    stageprefix = stageprefix + (stageidx + "_");
    stagelength = getstructfield(bundle, stageprefix + "length");
    if(!isdefined(stagelength)) {
      finishplayingpostfxbundle(localclientnum, stageprefix + "length not defined", filterid);
      return;
    }
    stagelength = stagelength * 1000;
    stagematerial = getstructfield(bundle, stageprefix + "material");
    if(!isdefined(stagematerial)) {
      finishplayingpostfxbundle(localclientnum, stageprefix + "material not defined", filterid);
      return;
    }
    filter::map_material_helper(self, stagematerial);
    setfilterpassmaterial(localclientnum, filterid, 0, filter::mapped_material_id(stagematerial));
    setfilterpassenabled(localclientnum, filterid, 0, 1, 0, firstpersononly);
    stagecapture = getstructfield(bundle, stageprefix + "screenCapture");
    if(isdefined(stagecapture) && stagecapture) {
      if(isdefined(self.captureimagename)) {
        freecodeimage(localclientnum, self.captureimagename);
        self.captureimagename = undefined;
        setfilterpasscodetexture(localclientnum, filterid, 0, 0, "");
      }
      self.captureimagename = stageprefix + playbundlename;
      createscenecodeimage(localclientnum, self.captureimagename);
      captureframe(localclientnum, self.captureimagename);
      setfilterpasscodetexture(localclientnum, filterid, 0, 0, self.captureimagename);
    }
    stagesprite = getstructfield(bundle, stageprefix + "spriteFilter");
    if(isdefined(stagesprite) && stagesprite) {
      setfilterpassquads(localclientnum, filterid, 0, 2048);
    } else {
      setfilterpassquads(localclientnum, filterid, 0, 0);
    }
    thermal = getstructfield(bundle, stageprefix + "thermal");
    enablethermaldraw(localclientnum, isdefined(thermal) && thermal);
    loopingstage = looping && (!enterstage && stageidx == 0 || (enterstage && stageidx == 1));
    accumtime = 0;
    prevtime = self getclienttime();
    while (loopingstage || accumtime < stagelength && !self.forcestoppostfxbundle) {
      gfx::setstage(localclientnum, bundle, filterid, stageprefix, stagelength, accumtime, totalaccumtime, & setfilterconstants);
      wait(0.016);
      currtime = self getclienttime();
      deltatime = currtime - prevtime;
      accumtime = accumtime + deltatime;
      totalaccumtime = totalaccumtime + deltatime;
      prevtime = currtime;
      if(loopingstage) {
        while (accumtime >= stagelength) {
          accumtime = accumtime - stagelength;
        }
        if(self.exitpostfxbundle) {
          loopingstage = 0;
          if(!finishlooponexit) {
            break;
          }
        }
      }
    }
    setfilterpassenabled(localclientnum, filterid, 0, 0);
  }
  finishplayingpostfxbundle(localclientnum, "Finished " + playbundlename, filterid);
}

function watchentityshutdown(localclientnum, filterid) {
  self util::waittill_any("entityshutdown", "death", "finished_playing_postfx_bundle");
  finishplayingpostfxbundle(localclientnum, "Entity Shutdown", filterid);
}

function setfilterconstants(localclientnum, shaderconstantname, filterid, values) {
  baseshaderconstindex = gfx::getshaderconstantindex(shaderconstantname);
  setfilterpassconstant(localclientnum, filterid, 0, baseshaderconstindex + 0, values[0]);
  setfilterpassconstant(localclientnum, filterid, 0, baseshaderconstindex + 1, values[1]);
  setfilterpassconstant(localclientnum, filterid, 0, baseshaderconstindex + 2, values[2]);
  setfilterpassconstant(localclientnum, filterid, 0, baseshaderconstindex + 3, values[3]);
}

function finishplayingpostfxbundle(localclientnum, msg, filterid) {
  if(isdefined(msg)) {
    println(msg);
  }
  if(isdefined(self)) {
    self notify("finished_playing_postfx_bundle");
    self.forcestoppostfxbundle = 0;
    self.exitpostfxbundle = 0;
    self.playingpostfxbundle = "";
  }
  setfilterpassquads(localclientnum, filterid, 0, 0);
  setfilterpassenabled(localclientnum, filterid, 0, 0);
  enablethermaldraw(localclientnum, 0);
  if(isdefined(self.captureimagename)) {
    setfilterpasscodetexture(localclientnum, filterid, 0, 0, "");
    freecodeimage(localclientnum, self.captureimagename);
    self.captureimagename = undefined;
  }
}

function stopplayingpostfxbundle() {
  if(self.playingpostfxbundle != "") {
    stoppostfxbundle();
  }
}

function stoppostfxbundle() {
  self notify("stoppostfxbundle_singleton");
  self endon("stoppostfxbundle_singleton");
  if(isdefined(self.playingpostfxbundle) && self.playingpostfxbundle != "") {
    self.forcestoppostfxbundle = 1;
    while (self.playingpostfxbundle != "") {
      wait(0.016);
      if(!isdefined(self)) {
        return;
      }
    }
  }
}

function exitpostfxbundle() {
  if(!(isdefined(self.exitpostfxbundle) && self.exitpostfxbundle) && isdefined(self.playingpostfxbundle) && self.playingpostfxbundle != "") {
    self.exitpostfxbundle = 1;
  }
}

function setfrontendstreamingoverlay(localclientnum, system, enabled) {
  if(!isdefined(self.overlayclients)) {
    self.overlayclients = [];
  }
  if(!isdefined(self.overlayclients[localclientnum])) {
    self.overlayclients[localclientnum] = [];
  }
  self.overlayclients[localclientnum][system] = enabled;
  foreach(en in self.overlayclients[localclientnum]) {
    if(en) {
      enablefrontendstreamingoverlay(localclientnum, 1);
      return;
    }
  }
  enablefrontendstreamingoverlay(localclientnum, 0);
}