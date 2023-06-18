/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [id_turma]
      ,[id_aluno]
      ,[valor]
      ,[valor_desconto]
      ,[data_cadastro]
      ,[login_cadastro]
  FROM [SQL_SERVER_TROVATO].[dbo].[AlunosxTurmas]


  select * from 
  (
  select id_turma as Turma,
		 [id_aluno] Alunos
  FROM [SQL_SERVER_TROVATO].[dbo].[AlunosxTurmas]
  ) t pivot (count([Alunos]) for Turma in ([1], [6], [10])) as qtd_Alunos
