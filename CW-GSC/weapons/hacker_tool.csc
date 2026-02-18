/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\hacker_tool.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#namespace hacker_tool;

function init_shared() {
  clientfield::register("toplayer", "hacker_tool", 1, 2, "int", &player_hacking, 0, 0);
  level.hackingsoundid = [];
  level.hackingsweetspotid = [];
  level.friendlyhackingsoundid = [];
  callback::on_localplayer_spawned(&on_localplayer_spawned);
}

function on_localplayer_spawned(localclientnum) {
  if(!self function_21c0fa55()) {
    return;
  }

  player = self;

  if(isDefined(level.hackingsoundid[localclientnum])) {
    player stoploopsound(level.hackingsoundid[localclientnum]);
    level.hackingsoundid[localclientnum] = undefined;
  }

  if(isDefined(level.hackingsweetspotid[localclientnum])) {
    player stoploopsound(level.hackingsweetspotid[localclientnum]);
    level.hackingsweetspotid[localclientnum] = undefined;
  }

  if(isDefined(level.friendlyhackingsoundid[localclientnum])) {
    player stoploopsound(level.friendlyhackingsoundid[localclientnum]);
    level.friendlyhackingsoundid[localclientnum] = undefined;
  }
}

function player_hacking(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self notify(#"player_hacking_callback");
  player = self;

  if(isDefined(level.hackingsoundid[fieldname])) {
    player stoploopsound(level.hackingsoundid[fieldname]);
    level.hackingsoundid[fieldname] = undefined;
  }

  if(isDefined(level.hackingsweetspotid[fieldname])) {
    player stoploopsound(level.hackingsweetspotid[fieldname]);
    level.hackingsweetspotid[fieldname] = undefined;
  }

  if(isDefined(level.friendlyhackingsoundid[fieldname])) {
    player stoploopsound(level.friendlyhackingsoundid[fieldname]);
    level.friendlyhackingsoundid[fieldname] = undefined;
  }

  if(isDefined(player.targetent)) {
    player.targetent.isbreachingfirewall = 0;
    player.targetent = undefined;
  }

  if(bwastimejump == 2) {
    player thread watchhackspeed(fieldname, 0);
    setuimodelvalue(createuimodel(function_1df4c3b0(fieldname, #"blackhat"), "status"), 2);
    return;
  }

  if(bwastimejump == 3) {
    player thread watchhackspeed(fieldname, 1);
    setuimodelvalue(createuimodel(function_1df4c3b0(fieldname, #"blackhat"), "status"), 1);
    return;
  }

  if(bwastimejump == 1) {
    setuimodelvalue(createuimodel(function_1df4c3b0(fieldname, #"blackhat"), "status"), 0);
    setuimodelvalue(createuimodel(function_1df4c3b0(fieldname, #"blackhat"), "perc"), 0);
    setuimodelvalue(createuimodel(function_1df4c3b0(fieldname, #"blackhat"), "offsetShaderValue"), "0 0 0 0");
    self thread watchforemp(fieldname);
    return;
  }

  setuimodelvalue(createuimodel(function_1df4c3b0(fieldname, #"blackhat"), "status"), 0);
  setuimodelvalue(createuimodel(function_1df4c3b0(fieldname, #"blackhat"), "perc"), 0);
  setuimodelvalue(createuimodel(function_1df4c3b0(fieldname, #"blackhat"), "offsetShaderValue"), "0 0 0 0");
}

function watchhackspeed(localclientnum, isbreachingfirewall) {
  self endon(#"death");
  self endon(#"player_hacking_callback");
  player = self;

  for(;;) {
    targetentarray = self gettargetlockentityarray();

    if(targetentarray.size > 0) {
      targetent = targetentarray[0];
      break;
    }

    wait 0.02;
  }

  targetent watchtargethack(localclientnum, player, isbreachingfirewall);
}

function watchtargethack(localclientnum, player, isbreachingfirewall) {
  self endon(#"death");
  player endon(#"death");
  self endon(#"player_hacking_callback");
  targetent = self;
  player.targetent = targetent;

  if(isbreachingfirewall) {
    targetent.isbreachingfirewall = 1;
  }

  targetent thread watchhackerplayershutdown(localclientnum, player, targetent);

  for(;;) {
    distancefromcenter = targetent getdistancefromscreencenter(localclientnum);
    inverse = 40 - distancefromcenter;
    ratio = inverse / 40;
    heatval = getweaponhackratio(localclientnum);
    ratio = ratio * ratio * ratio * ratio;

    if(ratio > 1 || ratio < 0.001) {
      ratio = 0;
      horizontal = 0;
    } else {
      horizontal = targetent gethorizontaloffsetfromscreencenter(localclientnum, 40);
    }

    setuimodelvalue(createuimodel(function_1df4c3b0(localclientnum, #"blackhat"), "offsetShaderValue"), horizontal + " " + ratio + " 0 0");
    setuimodelvalue(createuimodel(function_1df4c3b0(localclientnum, #"blackhat"), "perc"), heatval);

    if(ratio > 0.8) {
      if(!isDefined(level.hackingsweetspotid[localclientnum])) {
        level.hackingsweetspotid[localclientnum] = player playLoopSound(#"evt_hacker_hacking_sweet");
      }
    } else {
      if(isDefined(level.hackingsweetspotid[localclientnum])) {
        player stoploopsound(level.hackingsweetspotid[localclientnum]);
        level.hackingsweetspotid[localclientnum] = undefined;
      }

      if(!isDefined(level.hackingsoundid[localclientnum])) {
        level.hackingsoundid[localclientnum] = player playLoopSound(#"evt_hacker_hacking_loop");
      }

      if(isDefined(level.hackingsoundid[localclientnum])) {
        setsoundpitch(level.hackingsoundid[localclientnum], ratio);
      }
    }

    if(!isbreachingfirewall) {
      friendlyhacking = weaponfriendlyhacking(localclientnum);

      if(friendlyhacking && !isDefined(level.friendlyhackingsoundid[localclientnum])) {
        level.friendlyhackingsoundid[localclientnum] = player playLoopSound(#"evt_hacker_hacking_loop_mult");
      } else if(!friendlyhacking && isDefined(level.friendlyhackingsoundid[localclientnum])) {
        player stoploopsound(level.friendlyhackingsoundid[localclientnum]);
        level.friendlyhackingsoundid[localclientnum] = undefined;
      }
    }

    wait 0.1;
  }
}

function watchhackerplayershutdown(localclientnum, hackerplayer, targetent) {
  self endon(#"death");
  killstreakentity = self;
  hackerplayer endon(#"player_hacking_callback");
  hackerplayer waittill(#"death");

  if(isDefined(targetent)) {
    targetent.isbreachingfirewall = 1;
  }
}

function watchforemp(localclientnum) {
  self endon(#"death");
  self endon(#"player_hacking_callback");

  while(true) {
    if(self isempjammed()) {
      setuimodelvalue(createuimodel(function_1df4c3b0(localclientnum, #"blackhat"), "status"), 3);
    } else {
      setuimodelvalue(createuimodel(function_1df4c3b0(localclientnum, #"blackhat"), "status"), 0);
    }

    wait 0.1;
  }
}