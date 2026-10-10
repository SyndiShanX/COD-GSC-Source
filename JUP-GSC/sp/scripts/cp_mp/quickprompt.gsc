/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp_mp\quickprompt.gsc
***********************************************/

#using scripts\engine\utility;
#namespace quickprompt;

function private waitfornotify(waitobject, promptid) {
  waitobject endon("end_wait");
  result = undefined;

  while(!isDefined(result) || result != promptid) {
    self waittill("ok", result);
  }

  waitobject notify("end_wait", 1);
}

function private waitfortimeout(waitobject, timeout) {
  waitobject endon("end_wait");
  wait timeout;
  waitobject notify("end_wait", 0);
}

function private waitforconfirmation(promptid, timeout) {
  waitobject = spawnStruct();
  childthread waitfornotify(waitobject, promptid);
  childthread waitfortimeout(waitobject, timeout);
  waitobject waittill("end_wait", var_63f39f46151661f8);
  return var_63f39f46151661f8;
}

function private function_cf06da592218629(soundtype) {
  assert(isDefined(self) && isPlayer(self));

  if(issharedfuncdefined("sound", "trySayLocalSound")) {
    level thread[[getsharedfunc("sound", "trySayLocalSound")]](self, soundtype);
  }
}

function private function_3fc6bd204b38a2f5() {
  if(!isDefined(level.var_a7073b092595736e)) {
    level.var_a7073b092595736e = 0;
  }

  promptid = level.var_a7073b092595736e;
  level.var_a7073b092595736e += 1;
  return promptid;
}

function private function_b8da10afdee4ecb6() {
  return getdvarint(@ "hash_923b34c4661bf18d", 500);
}

function private getservertimeout(clienttimeout) {
  var_bd28f5a584bf2110 = 1000;
  var_1048e24f7ecfd108 = function_b8da10afdee4ecb6();
  return (clienttimeout + var_bd28f5a584bf2110 + var_1048e24f7ecfd108) / 1000;
}

function private function_81e08a62a6b5c2fc(timeout) {
  defaulttimeout = 5000;

  if(isDefined(timeout)) {
    return (timeout * 1000);
  }

  return getdvarint(@ "hash_9feed7a9d0b00557", defaulttimeout);
}

function private function_48c352e46a0677d1(prompttype) {
  if(prompttype == 5 || prompttype == 6) {
    return 0;
  }

  return 1;
}

function private function_5fe394c76f3bb67e(prompttype) {
  if(prompttype == 2) {
    return true;
  }

  return false;
}

function function_7ba31cb6b21c346f() {
  return istrue(getdvarint(@ "hash_7023569777f7f76d", 1));
}

function function_9e4834f9ae737884() {
  assert(isDefined(self) && isPlayer(self));
  return isDefined(self.quickprompt);
}

function function_74c8eb2aaf9f5d14(prompttype) {
  assert(isDefined(self) && isPlayer(self));

  if(isDefined(self.quickprompt)) {
    return (self.quickprompt.type == prompttype);
  }

  return false;
}

function function_36edf91561322753(prompttype, timeout, callback) {
  assert(isDefined(self) && isPlayer(self));

  if(!function_7ba31cb6b21c346f()) {
    return;
  }

  if(isDefined(self.quickprompt) && isDefined(self.quickprompt.allowoverride) && !self.quickprompt.allowoverride) {
    return;
  }

  self endon("death_or_disconnect");
  level endon("game_ended");
  promptid = function_3fc6bd204b38a2f5();
  prompttimeout = function_81e08a62a6b5c2fc(timeout);
  allowoverride = function_48c352e46a0677d1(prompttype);
  var_5fe394c76f3bb67e = function_5fe394c76f3bb67e(prompttype);
  function_50d712d830effa82(self, prompttype, promptid, int(prompttimeout), var_5fe394c76f3bb67e);
  self.quickprompt = spawnStruct();
  self.quickprompt.allowoverride = allowoverride;
  self.quickprompt.callback = callback;
  self.quickprompt.type = prompttype;
  self.quickprompt.promptid = promptid;
  servertimeout = getservertimeout(prompttimeout);
  var_63f39f46151661f8 = waitforconfirmation(promptid, servertimeout);

  if(var_63f39f46151661f8) {
    switch (prompttype) {
      case 1:
      case 2:
      case 3:
      case 4:
        function_cf06da592218629(#"ping_social_thanks");
        break;
      default:
        break;
    }
  }

  if(isDefined(self.quickprompt) && isDefined(self.quickprompt.callback)) {
    self[[self.quickprompt.callback]](var_63f39f46151661f8);
  }

  self.quickprompt = undefined;
}

function function_24a08f8a03be8244(var_8f23c9dc9608a79f) {
  if(isDefined(self.quickprompt)) {
    if(isDefined(var_8f23c9dc9608a79f) && var_8f23c9dc9608a79f && isDefined(self.quickprompt.callback)) {
      self[[self.quickprompt.callback]](0);
    }

    self.quickprompt = undefined;
    function_aa1b7c7a8261efef(self);
  }
}