/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\clouds.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace clouds;

function private autoexec __init__system__() {
  system::register(#"clouds", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.clouds = {
    #layers: []
  };
  function_f75dd8e0("low", 6000, #"hash_3cb3a6fc9eb00337");
  callback::add_callback(#"freefall", &function_c9a18304);
  callback::add_callback(#"skydive_end", &function_f99c2453);
}

function private function_c9a18304(eventstruct) {
  if(!(isPlayer(self) || self isplayercorpse())) {
    return;
  }

  if(self function_21c0fa55()) {
    self start(eventstruct.localclientnum);
  }
}

function private function_f99c2453(eventstruct) {
  if(!isPlayer(self)) {
    return;
  }

  if(self function_21c0fa55()) {
    self cleanup(eventstruct.localclientnum);
  }
}

function function_f75dd8e0(name, min_height, fx) {
  assert(!isDefined(level.clouds.layers[name]));
  level.clouds.layers[name] = {
    #name: name, #min_height: min_height, #fx: fx
  };
}

function private function_59a04cbf() {
  if(isDefined(level.var_427d6976.altimeterseaheight)) {
    return level.var_427d6976.altimeterseaheight;
  }

  return 0;
}

function start(localclientnum) {
  if(!isDefined(self.clouds)) {
    self.clouds = [];
  }

  height = self.origin[2];
  var_3c752058 = function_59a04cbf();

  foreach(layer in level.clouds.layers) {
    if(layer.min_height > height - var_3c752058) {
      continue;
    }

    if(isDefined(self.clouds[layer.name])) {
      continue;
    }

    self.clouds[layer.name] = util::playFXOnTag(localclientnum, layer.fx, self, "tag_origin");
  }

  self thread update(localclientnum);
}

function update(localclientnum) {
  self endon(#"death", #"hash_44d009a3793f7389");
  var_3c752058 = function_59a04cbf();

  while(true) {
    foreach(name, fx in self.clouds) {
      if(self.origin[2] < level.clouds.layers[name].min_height - var_3c752058) {
        self function_2baaca3c(localclientnum, name);
      }
    }

    if(self.clouds.size == 0) {
      return;
    }

    wait 1;
  }
}

function cleanup(localclientnum) {
  self notify(#"hash_44d009a3793f7389");

  if(!isDefined(self.clouds)) {
    self.clouds = [];
  }

  foreach(name, fx in self.clouds) {
    stopfx(localclientnum, self.clouds[name]);
  }

  self.clouds = [];
}

function function_2baaca3c(localclientnum, name) {
  if(isDefined(self.clouds[name])) {
    stopfx(localclientnum, self.clouds[name]);
    self.clouds[name] = undefined;
  }
}