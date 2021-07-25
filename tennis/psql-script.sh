CREATE VIEW tournament_event_view AS
	SELECT tournament_event_id, season
	FROM tournament_event
	WHERE name='Australian Open' AND season>2011;

CREATE VIEW match_view AS
	SELECT tournament_event_view.season, match.*
	FROM match NATURAL JOIN tournament_event_view
	ORDER BY tournament_event_view.season ASC;

CREATE VIEW match_stats_view AS
	SELECT match_stats.*
	FROM match_stats NATURAL JOIN match_view;

CREATE VIEW set_score_view AS
	SELECT set_score.*
	FROM set_score NATURAL JOIN match_view;

CREATE VIEW player_view AS
	SELECT DISTINCT player_id, first_name, last_name
	FROM player JOIN match_view ON player.player_id=match_view.loser_id OR
	                               player.player_id=match_view.winner_id;

\copy (SELECT * FROM match_view) TO '/tmp/tennis/match.csv' CSV HEADER;
\copy (SELECT * FROM match_stats_view) TO '/tmp/tennis/match_stats.csv' CSV HEADER;
\copy (SELECT * FROM set_score_view) TO '/tmp/tennis/set_score.csv' CSV HEADER;
\copy (SELECT * FROM player_view) TO '/tmp/tennis/player.csv' CSV HEADER;

DROP VIEW tournament_event_view, match_view,
          match_stats_view, set_score_view, player_view;
