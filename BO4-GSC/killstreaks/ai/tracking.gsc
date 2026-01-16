/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\ai\tracking.gsc
***********************************************/

#namespace tracking;

private function_605bb988() {
  if(!isalive(self)) {
    return false;
  }

  return true;
}

private function_8240e8b4() {
  if(function_605bb988()) {
    if(level.time >= self.tracking.breadcrumbs[self.tracking.current_crumb].time + self.tracking.time_step) {
      return;
    }

    self.tracking.current_crumb = (self.tracking.current_crumb + 1) % 20;
    self.tracking.breadcrumbs[self.tracking.current_crumb] = {
      #point: self.origin, 
      #time: level.time
    };
  }
}

init_tracking(window) {
  self.tracking = {
    #breadcrumbs: [], 
    #current_crumb: 0, 
    #var_712fc53e: 0, 
    #velocity: (0, 0, 0), 
    #speed: 0, 
    #window: window, 
    #time_step: int(window * 1000) / 20
  };
  crumb = {
    #point: self.origin, 
    #time: level.time
  };

  if(!isDefined(self.tracking.breadcrumbs)) {
    self.tracking.breadcrumbs = [];
  } else if(!isarray(self.tracking.breadcrumbs)) {
    self.tracking.breadcrumbs = array(self.tracking.breadcrumbs);
  }

  self.tracking.breadcrumbs[self.tracking.breadcrumbs.size] = crumb;
}

private track_points() {
  self endon(#"disconnect");

  while(true) {
    self function_8240e8b4();
    waitframe(1);
  }
}

track(window) {
  if(isDefined(self.tracking)) {
    return;
  }

  self init_tracking(window);
  self thread track_points();
}

get_velocity() {
  if(level.time == self.tracking.var_712fc53e) {
    return self.tracking.velocity;
  }

  crumb_index = self.tracking.current_crumb % 20;
  crumb = self.tracking.breadcrumbs[crumb_index];
  last_point = crumb.point;
  last_time = crumb.time;
  travel = (0, 0, 0);
  total_time = 0;
  breadcrumb_count = self.tracking.breadcrumbs.size;

  for(index = breadcrumb_count - 2; index >= 0; index--) {
    crumb_index--;

    if(crumb_index < 0) {
      crumb_index += breadcrumb_count;
    }

    crumb = self.tracking.breadcrumbs[crumb_index];
    travel += last_point - crumb.point;
    total_time += last_time - crumb.time;
    last_point = crumb.point;
    last_time = crumb.time;
  }

  if(total_time > 0) {
    self.tracking.velocity = travel / float(total_time) / 1000;
    self.tracking.speed = length(travel) / float(total_time) / 1000;
  }

  self.tracking.var_712fc53e = level.time;
  return self.tracking.velocity;
}

debug_tracking() {
  self endon(#"disconnect");

  while(true) {
    if(function_605bb988()) {
      velocity = self get_velocity();
      sphere(self.origin + velocity, 10, (1, 0, 0), 1, 0);
    }

    waitframe(1);
  }
}

