-- средние значения зп после удержания налогов
SELECT
    area_id,
    avg(CASE compensation_gross
          WHEN TRUE THEN compensation_from * 0.87
          ELSE compensation_from
        END) AS avg_compensation_from,
    avg(CASE compensation_gross
        WHEN TRUE THEN compensation_to * 0.87
        ELSE compensation_to
        END) AS avg_compensation_to,
      -- если в вакансии указана только верхняя или только нижняя граница, арифметическое будем считать равным этому значению 
    avg(CASE compensation_gross
           WHEN TRUE THEN 0.87
           ELSE 1
        END
           * (coalesce(compensation_from,compensation_to) + coalesce(compensation_to,compensation_from) ) / 2)
                                AS avg_среднее_арифметическое_from_и_to
FROM vacancy v
GROUP BY area_id;
