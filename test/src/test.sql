-- SQL: DDL/DML予約語、データ型、集計関数、結合、CTE（WITH句）、CASE文の確認用
WITH RankedColors AS (
    SELECT
        c.color_id,
        c.color_name,
        c.hex_code,
        c.category_id,
        ROW_NUMBER() OVER (PARTITION BY c.category_id ORDER BY c.color_id ASC) AS rank_in_cat
    FROM
        traditional_palette AS c
    WHERE
        c.is_active = TRUE
        AND c.hex_code LIKE '#%'
)
SELECT
    r.color_id,
    UPPER(r.color_name) AS formatted_name,
    COALESCE(r.hex_code, '#000000') AS hex,
    CASE
        WHEN r.category_id = 1 THEN '白灰系'
        WHEN r.category_id = 2 THEN '青鼠系'
        ELSE '茶系'
    END AS category_label
FROM
    RankedColors AS r
INNER JOIN
    palette_categories AS cat ON r.category_id = cat.id
GROUP BY
    r.color_id, r.color_name, r.hex_code, r.category_id
HAVING
    COUNT(*) > 0
ORDER BY
    r.color_id ASC
LIMIT 100;
