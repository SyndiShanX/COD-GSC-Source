/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\globallogic_tickets.gsc
*******************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\math_shared;

#namespace tickets;

autoexec __init__() {
  callback::on_player_killed(&on_player_killed);
}

reset_match_start(total_stages) {
  if(game.tickets_initialized === 1) {
    return;
  }

  reset_stages(total_stages);
  reset_tickets();
  game.tickets_initialized = 1;
}

reset_stages(total_stages) {
  game.stat[#"stagetickets"] = [];

  foreach(team, _ in level.teams) {
    game.stat[#"stagetickets"][team] = [];

    for(stage = 0; stage < total_stages; stage++) {
      game.stat[#"stagetickets"][team][stage] = 0;
    }
  }
}

reset_tickets() {
  game.stat[#"tickets"] = [];

  foreach(team, _ in level.teams) {
    game.stat[#"tickets"][team] = 0;
  }
}

setup_mission_ticket_logic(team, zone_index) {
  setup_stage_start_tickets(team, zone_index);
  thread setup_death_penalties(team);
  thread watch_time_penalties(team);
}

setup_stage_start_tickets(team, zone_index) {
  reset_tickets();
  zone_start_tickets = get_zone_start_tickets(zone_index);
  set_tickets(team, zone_start_tickets);
}

get_zone_start_tickets(zone_index) {
  return isDefined(getgametypesetting(#"ticketsgivenatstagestart_" + zone_index)) ? getgametypesetting(#"ticketsgivenatstagestart_" + zone_index) : 0;
}

watch_time_penalties(team) {
  level notify(#"tickets_watch_time_penalties");
  level endon(#"tickets_watch_time_penalties", #"mission_ended", #"game_ended");

  while(true) {
    penalty_interval = isDefined(getgametypesetting(#"ticketslostontimeinterval")) ? getgametypesetting(#"ticketslostontimeinterval") : 0;

    if(penalty_interval <= 0) {
      wait 0.5;
      continue;
    }

    frames_to_wait = int(ceil(penalty_interval / float(function_60d95f53()) / 1000));
    waitframe(frames_to_wait);
    lose_tickets(team, isDefined(getgametypesetting(#"ticketslostontimeamount")) ? getgametypesetting(#"ticketslostontimeamount") : 0);
  }
}

setup_death_penalties(team) {
  level.ticket_death_penalty_team = team;
}

on_player_killed() {
  player = self;

  if(!isplayer(player)) {
    return;
  }

  if(!isDefined(player.team)) {
    return;
  }

  if(!isDefined(level.ticket_death_penalty_team)) {
    return;
  }

  if(level.ticket_death_penalty_team == player.team) {
    death_penalty = isDefined(getgametypesetting(#"ticketslostondeath")) ? getgametypesetting(#"ticketslostondeath") : 0;

    if(death_penalty > 0) {
      lose_tickets(player.team, death_penalty);
      level notify(#"ticket_death", {
        #team: player.team
      });
    }
  }
}

set_tickets(team, tickets) {
  original_total = game.stat[#"tickets"][team];
  game.stat[#"tickets"][team] = tickets;
  notify_tickets_updated(team, original_total);
}

earn_tickets(team, tickets) {
  original_total = game.stat[#"tickets"][team];
  game.stat[#"tickets"][team] += tickets;
  clamp_tickets(team);
  notify_tickets_updated(team, original_total);
}

lose_tickets(team, tickets) {
  original_total = game.stat[#"tickets"][team];
  game.stat[#"tickets"][team] -= tickets;
  clamp_tickets(team);
  notify_tickets_updated(team, original_total);
}

notify_tickets_updated(team, original_total) {
  if(original_total != game.stat[#"tickets"][team]) {
    level notify(#"tickets_updated", {
      #team: team, 
      #total_tickets: game.stat[#"tickets"][team]
    });
    low_ticket_threshold = 30;
    very_low_ticket_threshold = 10;

    if(getdvarint(#"scr_disable_war_score_limits", 0) > 0) {
      low_ticket_threshold = -1;
      very_low_ticket_threshold = -1;
    }

      low_tickets_enabled = level.low_tickets_enabled === 1;
    level.low_ticket_count = game.stat[#"tickets"][team] <= low_ticket_threshold && !level.inprematchperiod && low_tickets_enabled;
    level.very_low_ticket_count = game.stat[#"tickets"][team] <= very_low_ticket_threshold && !level.inprematchperiod && low_tickets_enabled;
  }
}

private clamp_tickets(team) {
  game.stat[#"tickets"][team] = math::clamp(game.stat[#"tickets"][team], 0, 2147483647);
}

commit_tickets(team, stage) {
  game.stat[#"stagetickets"][team][stage] = game.stat[#"tickets"][team];
  notify_stage_tickets_updated(team, stage);
}

award_stage_win(team, stage) {
  earned_tickets = get_stage_win_tickets(stage);

  if(earned_tickets > 0) {
    earn_tickets(team, earned_tickets);
  }
}

get_stage_win_tickets(stage) {
  return isDefined(getgametypesetting(#"ticketsearnedatstagewin_" + stage)) ? getgametypesetting(#"ticketsearnedatstagewin_" + stage) : 0;
}

get_tickets(team) {
  if(!isDefined(game.tickets_initialized) || !game.tickets_initialized) {
    return 0;
  }

  return game.stat[#"tickets"][team];
}

get_stage_tickets(team, stage) {
  if(!isDefined(game.tickets_initialized) || !game.tickets_initialized) {
    return 0;
  }

  return game.stat[#"stagetickets"][team][stage];
}

notify_stage_tickets_updated(team, stage) {
  level notify(#"tickets_stage_updated", {
    #team: team, 
    #zone_number: stage, 
    #total_tickets: game.stat[#"stagetickets"][team][stage]
  });
}

get_total_tickets(team, total_stages) {
  team_total = 0;

  for(i = 0; i < total_stages; i++) {
    team_total += get_stage_tickets(team, i);
  }

  return team_total;
}