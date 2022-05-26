CREATE TABLE IF NOT EXISTS "task_status"(
  "id" serial PRIMARY key,
  "description" CHAR(255) NOT NULL
);

INSERT INTO task_status (id, description) 
VALUES
(1, 'COMPLETED'),
(2, 'INCOMPLETE'),
(3, 'PUSHED'),
(4, 'CANCELLED');