/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_60a074124cbc61f1.gsc
*****************************************************/

#namespace bounding_overwatch;

function getfunction(funcid) {
  switch (funcid) {
    case #"hash_dab0d83df51da4d":
      return &onuserinit;
    case #"hash_722d767fd6d40f56":
      return &onuserterminate;
    case #"hash_a05c4b59049a1b76":
      return &holdcurrentground;
    case #"hash_b7e113799080c8":
      return &requestadvanceontarget;
    case #"hash_713dc5b1c250d91c":
      return &coveringfire;
    case #"hash_a3836dc7307ecb50":
      return &coveringfirecleanup;
  }

  assertmsg("<dev string:x24>" + funcid);
}

function onuserinit(interactionid) {}

function onuserterminate(interactionid) {}

function requestadvanceontarget(statename, params) {
  self function_a6b824be0ad9855e();
}

function holdcurrentground(statename, params) {
  if(istrue(params[0])) {
    self.var_f17fb3445f56e42c = 1;
    return;
  }

  self.var_f17fb3445f56e42c = 0;
}

function coveringfire(statename, params) {
  self.maxfaceenemydistcache = self.maxfaceenemydist;
  self.maxfaceenemydist = 2048;
  var_a78610ceb1ecfd0e = 3000;
  var_52f11d5ad0faeee4 = gettime() + 10000;
  self.balwayscoverexposed = 1;
  self.providecoveringfire = 1;
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.shootstyleoverride = "\x84\x9b\x8cB";
}

function coveringfirecleanup(statename, params) {
  self.maxfaceenemydist = self.maxfaceenemydistcache;
  self.maxfaceenemydistcache = undefined;
  self.balwayscoverexposed = 0;
  self.providecoveringfire = 0;
  self.shootstyleoverride = undefined;
}