declare @json nvarchar(max);

set @json = 
N'{
  "clientes": [
    {
      "id": 1,
      "name": "João",
      "age": 30,
	  "demographics": {"hhi": ">150k", "education": "college"},
	  "dob": "1982-08-24"
    },
    {
      "id": 2,
      "name": "Maria",
      "age": 25,
	  "demographics": {"hhi": "<100k"}
    },
    {
      "id": 3,
      "name": "Pedro",
      "age": 35,
	  "demographics": { "education": "secondary"},
	  "dob": "1986-01-19"
    }
  ]
}'

select 
	id,
	age,
	name,
	hhi,
	dob,
	isnull(education, 'not sure') education
from OPENJSON(@json, '$.clientes') 
with (
	id int '$.id', 
	age int '$.age', 
	name nvarchar(30) '$.name',
	hhi varchar(50) '$.demographics.hhi',
	dob date '$.dob',
	education varchar(300) '$.demographics.education'
)

select JSON_VALUE(@json, '$.clientes[1].name') as name

--table to json
select top 5
	id_aluno [aluno.id_aluno], nome [aluno.nome], data_nascimento [aluno.dt_nascimento], sexo [aluno.sexo], 
	case when sexo = 'f' then 'y' else 'n' end as [aluno.estrategia.target],
	DATEDIFF(year, data_nascimento, getdate()) as [aluno.estrategia.idade]
from alunos
for json path, root('Alunos')

declare @json varchar(max) 
set @json = '{"Alunos":[{"aluno":{"id_aluno":1,"nome":"Alan Moraes","dt_nascimento":"1989-09-04","sexo":"M","estrategia":{"target":"n","idade":34}}},{"aluno":{"id_aluno":2,"nome":"Alessandro Soares","dt_nascimento":"1989-10-04","sexo":"M","estrategia":{"target":"n","idade":34}}},{"aluno":{"id_aluno":3,"nome":"Alexander Peres","dt_nascimento":"1989-08-22","sexo":"M","estrategia":{"target":"n","idade":34}}},{"aluno":{"id_aluno":4,"nome":"Alexandre Sayuri","dt_nascimento":"1989-04-25","sexo":"M","estrategia":{"target":"n","idade":34}}},{"aluno":{"id_aluno":5,"nome":"Alexandre Moraes","dt_nascimento":"1989-06-06","sexo":"M","estrategia":{"target":"n","idade":34}}}]}'

--select ISJSON(@json)

select JSON_QUERY(@json, '$.Alunos[*].aluno.nome')


