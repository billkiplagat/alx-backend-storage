-- Creates a stored procedure ComputeAverageScoreForUser that
-- computes and store the average score for a student.
DROP PROCEDURE IF EXISTS ComputeAverageScoreForUser;
DELIMITER //

CREATE PROCEDURE ComputeAverageScoreForUser(
    IN p_user_id INT
)
BEGIN
    DECLARE total_score INT;
    DECLARE total_projects INT;
    DECLARE average_score FLOAT;

    -- Compute total score and total projects for the user
    SELECT SUM(score), COUNT(project_id)
    INTO total_score, total_projects
    FROM corrections
    WHERE user_id = p_user_id;

    -- Compute the average score
    IF total_projects > 0 THEN
        SET average_score = total_score / total_projects;
    ELSE
        SET average_score = 0;
    END IF;

    -- Update the average_score in the users table
    UPDATE users
    SET average_score = average_score
    WHERE id = p_user_id;
END;
//

DELIMITER ;

