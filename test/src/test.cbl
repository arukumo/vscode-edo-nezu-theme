*================================================================*
      * 江戸伝統色テーマ - COBOL 構文解析検証プログラム                 *
      * DIVISION/SECTION宣言、80桁固定フォーマット（エリアA/B）、PIC句、PERFORMループ、DISPLAY文の確認用
      *================================================================*
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TESTTHEME.
       AUTHOR. EDONEZU DEVELOPER.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-THEME-NAME          PIC X(20) VALUE 'edo-nezu-theme'.
       01  WS-COLOR-COUNT         PIC 9(02) VALUE 03.
       01  WS-INDEX               PIC 9(02) VALUE 01.

       01  WS-PALETTE-TABLE.
           05  WS-COLOR-ENTRY OCCURS 3 TIMES.
               10  WS-COLOR-ID    PIC 9(02).
               10  WS-COLOR-NAME  PIC N(06).
               10  WS-COLOR-HEX   PIC X(07).

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           DISPLAY "=== " WS-THEME-NAME " VALIDATION ==="

           MOVE 01 TO WS-COLOR-ID(1)
           MOVE NC"白鼠" TO WS-COLOR-NAME(1)
           MOVE "#dcdddd" TO WS-COLOR-HEX(1)

           MOVE 02 TO WS-COLOR-ID(2)
           MOVE NC"舛花色" TO WS-COLOR-NAME(2)
           MOVE "#567a98" TO WS-COLOR-HEX(2)

           PERFORM VARYING WS-INDEX FROM 1 BY 1
                   UNTIL WS-INDEX > 2
               DISPLAY "ID: " WS-COLOR-ID(WS-INDEX)
                       " NAME: " WS-COLOR-NAME(WS-INDEX)
                       " HEX: " WS-COLOR-HEX(WS-INDEX)
           END-PERFORM.

           STOP RUN.
