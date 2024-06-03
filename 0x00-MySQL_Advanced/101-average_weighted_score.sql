-- Creates a stored procedure ComputeAverageWeightedScoreForUsers that
-- computes and stores the average weighted score for all students.

-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS ComputeAverageWeightedScoreForUsers;

-- Change the delimiter for the CREATE PROCEDURE statement
DELIMITER //

-- Create the stored procedure
CREATE PROCEDURE ComputeAverageWeightedScoreForUsers ()
BEGIN
    -- Add new columns to store intermediate values
    ALTER TABLE users ADD total_weighted_score INT NOT NULL;
    ALTER TABLE users ADD total_weight INT NOT NULL;

    -- Calculate the total weighted score for each user
    UPDATE users
        SET total_weighted_score = (
            SELECT SUM(corrections.score * projects.weight)
            FROM corrections
            INNER JOIN projects ON corrections.project_id = projects.id
            WHERE corrections.user_id = users.id
        );

    -- Calculate the total weight for each user
    UPDATE users
        SET total_weight = (
            SELECT SUM(projects.weight)
            FROM corrections
            INNER JOIN projects ON corrections.project_id = projects.id
            WHERE corrections.user_id = users.id
        );

    -- Update the average_score using the calculated values
    UPDATE users
        SET users.average_score = IF(users.total_weight = 0, 0, users.total_weighted_score / users.total_weight);

    -- Remove the intermediate columns
    ALTER TABLE users DROP COLUMN total_weighted_score;
    ALTER TABLE users DROP COLUMN total_weight;
END;
//

-- Reset the delimiter to semicolon
DELIMITER ;
