/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1435f3c9fc699e04.gsc
***********************************************/

#namespace gameobjects;

function function_e553e480() {
  if(!isDefined(self.users)) {
    self.users = [];
  }

  self.var_a0ff5eb8 = 0;
  self.curprogress = 0;
  self.userate = 0;
  self.claimplayer = undefined;
  self.lastclaimtime = 0;
  self.claimgraceperiod = 0;
  self.mustmaintainclaim = 0;
  self.cancontestclaim = 0;
  self function_58901d83();
  self.var_5f35f19a = # "none";
}

function function_818d69ee(user) {
  if(!isDefined(self.users[user])) {
    self.users[user] = {};
  }

  if(!isDefined(self.users[user].touching)) {
    self.users[user].touching = {
      #num: 0, #rate: 0, #players: []
    };
  }
}

function function_136c2270(user) {
  if(!isDefined(self.users[user])) {
    self.users[user] = {};
  }

  if(!isDefined(self.users[user].contributors)) {
    self.users[user].contributors = [];
  }
}

function function_a1839d6b(user, player, key) {
  assert(isDefined(self.users[user]));
  assert(isDefined(self.users[user].contributors));

  if(!isDefined(self.users[user].contributors[key])) {
    contribution = {
      #player: player, #contribution: 0
    };
    self.users[user].contributors[key] = contribution;
  } else {
    contribution = self.users[user].contributors[key];
  }

  if(!isDefined(contribution.player)) {
    contribution.player = player;
  }

  contribution.starttime = gettime();
  contribution.var_e22ea52b = 1;
  return self.users[user].contributors[key];
}

function function_98aae7cf() {
  foreach(user in self.users) {
    user.contributors = undefined;
  }
}

function function_bd47b0c7() {
  function_98aae7cf();

  foreach(user_name, user in self.users) {
    if(user.touching.num > 0) {
      function_136c2270(user_name);

      foreach(var_5717fa0c, player in user.touching.players) {
        function_a1839d6b(user_name, player.player, var_5717fa0c);
      }
    }
  }
}

function function_f30290b(user, key) {
  if(isDefined(self.users[user]) && isDefined(self.users[user].contributors)) {
    self.users[user].contributors[key] = undefined;
  }
}

function function_339d0e91() {
  total = 0;

  foreach(var_b2dad138 in self.users) {
    total += var_b2dad138.touching.num;
  }

  return total;
}

function function_3a7a2963(var_77efb18) {
  total = 0;

  foreach(user_name, var_b2dad138 in self.users) {
    if(user_name == var_77efb18) {
      continue;
    }

    total += var_b2dad138.touching.num;
  }

  return total;
}

function function_3a29539b(var_77efb18) {
  foreach(user_name, var_b2dad138 in self.users) {
    if(user_name == var_77efb18) {
      continue;
    }

    if(var_b2dad138.touching.num > 0) {
      return true;
    }
  }

  return false;
}

function get_num_touching(user) {
  if(!isDefined(self.users[user])) {
    return 0;
  }

  return self.users[user].touching.num;
}

function function_e4cad37() {
  var_95e19dc6 = [];

  foreach(user, var_c4f3dc93 in self.users) {
    if(var_c4f3dc93.touching.num > 0) {
      if(!isDefined(var_95e19dc6)) {
        var_95e19dc6 = [];
      } else if(!isarray(var_95e19dc6)) {
        var_95e19dc6 = array(var_95e19dc6);
      }

      var_95e19dc6[var_95e19dc6.size] = user;
    }
  }

  return var_95e19dc6;
}

function function_4e3386a8(team) {
  return team;
}

function function_167d3a40() {
  return self.ownerteam;
}

function function_b64fb43d() {
  user = self function_167d3a40();

  if(!isDefined(self.users[user])) {
    return 0;
  }

  return self.users[user].touching.num;
}

function function_22c9de38(user, count = 1) {
  assert(isDefined(self.users[user]));
  assert(isDefined(self.users[user].touching));
  self.users[user].touching.num += count;
}

function function_26237f3c(user, count = 1) {
  assert(isDefined(self.users[user]));
  assert(isDefined(self.users[user].touching));
  self.users[user].touching.num -= count;

  if(self.users[user].touching.num < 1) {
    self.users[user].touching.num = 0;
  }
}

function function_5ea37c7c(func) {
  self.var_270e1029 = func;
}

function function_83eda4c0(user) {
  var_5b1365c0 = self.users[user].touching.num;
  return self function_ce47d61c(var_5b1365c0);
}

function function_ce47d61c(var_5b1365c0 = 0) {
  assert(self.var_9288c4c0 <= self.usetime);

  if(self.maxusers > 0) {
    var_5b1365c0 = min(var_5b1365c0, self.maxusers);
  }

  if(var_5b1365c0 > 1) {
    var_b13b89f5 = (var_5b1365c0 - 1) / (self.maxusers - 1);
    var_e2f3a95a = 1 / self.var_9288c4c0 / self.usetime - 1;
    rate = 1 + var_b13b89f5 * var_e2f3a95a;
    return rate;
  }

  return var_5b1365c0;
}

function function_9f894584(user) {
  if(!isDefined(self.users[user])) {
    return 0;
  }

  if(isDefined(self.var_270e1029)) {
    return self[[self.var_270e1029]](user);
  }

  if(self.var_a0ff5eb8) {
    userate = 0;

    if(self.users[user].touching.players.size > 0) {
      foreach(var_142bcc32 in self.users[user].touching.players) {
        if(isDefined(var_142bcc32.rate) && var_142bcc32.rate > userate) {
          userate = var_142bcc32.rate;
        }
      }
    }

    return userate;
  }

  return self.users[user].touching.rate;
}

function function_a7dbb00b(var_77efb18) {
  rate = 0;

  foreach(user_name, _ in self.users) {
    if(user_name == var_77efb18) {
      continue;
    }

    rate += function_9f894584(user_name);
  }

  return rate;
}

function function_21db7d02(numclaimants = 0, numother = 0) {
  if(numclaimants == numother || numclaimants < 0 || numother < 0) {
    return 0;
  }

  advantage = abs(numclaimants - numother);
  return self function_ce47d61c(advantage);
}

function function_f1342bb2(user, rate) {
  assert(isDefined(self.users[user]));
  assert(isDefined(self.users[user].touching));
  self.users[user].touching.rate += rate;
}

function function_27b84c22(user, rate) {
  assert(isDefined(self.users[user]));
  assert(isDefined(self.users[user].touching));
  self.users[user].touching.rate -= rate;

  if(self.users[user].touching.num < 1) {
    self.users[user].touching.rate = 0;
  }
}

function function_fdf87288(user, player, var_8a3ae0a0, var_5717fa0c) {
  assert(isDefined(self.users[user]));
  assert(isDefined(self.users[user].touching));
  self.users[user].touching.players[var_5717fa0c] = {
    #player: player, #rate: var_8a3ae0a0, #starttime: gettime()
  };
}

function function_472b3c15(user, var_5717fa0c) {
  assert(isDefined(self.users[user]));
  assert(isDefined(self.users[user].touching));
  self.users[user].touching.players[var_5717fa0c] = undefined;
}

function private is_player_touching(var_9b6a15e9, player) {
  foreach(touching_player in var_9b6a15e9) {
    if(touching_player.player == player) {
      return true;
    }
  }

  return false;
}

function function_73944efe(var_9b6a15e9, touch) {
  if(!isDefined(touch.player)) {
    return undefined;
  }

  if(!isPlayer(touch.player)) {
    owner = touch.player.owner;

    if(isDefined(owner) && isPlayer(owner)) {
      if(!is_player_touching(var_9b6a15e9, owner)) {
        return owner;
      }
    }
  } else {
    return touch.player;
  }

  return undefined;
}

function function_ebffa9f6(obj_id, team) {
  objective_setteam(obj_id, team);
}

function function_33420053(obj_id) {
  function_6da98133(obj_id);
}

function function_311b7785(obj_id) {
  function_4339912c(obj_id);
}

function function_e3cc1e96(obj_id, team) {
  function_29ef32ee(obj_id, team);
}

function function_6c27e90c(obj_id, team) {
  function_c939fac4(obj_id, team);
}

function function_58901d83() {
  self.var_5f35f19a = self.var_a4926509;
  self.var_a4926509 = # "none";
}

function function_7db44d1b(user) {
  if(user != # "none") {
    return true;
  }

  return false;
}

function function_350d0352() {
  return function_7db44d1b(self.var_a4926509);
}

function function_3e092344() {
  return function_7db44d1b(self.var_5f35f19a);
}

function function_14fccbd9() {
  return self.var_a4926509;
}

function function_4b64b7fd(team) {
  if(!isDefined(self.var_a4926509)) {
    return false;
  }

  if(team == self.var_a4926509) {
    return true;
  }

  return false;
}

function function_abe3458c() {
  if(!isDefined(self.var_a4926509)) {
    return false;
  }

  if(self.ownerteam == self.var_a4926509) {
    return true;
  }

  return false;
}

function function_abb86400() {
  if(self.ownerteam != # "neutral" && self.ownerteam != # "none") {
    return true;
  }

  return false;
}