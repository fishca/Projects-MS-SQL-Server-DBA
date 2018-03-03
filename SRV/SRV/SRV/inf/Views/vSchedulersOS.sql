﻿create view [inf].[vSchedulersOS] as
--Возвращает по одной строке для каждого планировщика SQL Server, сопоставленного с отдельным процессором
SELECT scheduler_id			--Идентификатор планировщика. Все планировщики, используемые для выполнения обычных запросов, имеют идентификаторы меньше 1048576.
							--Планировщики с идентификаторами, равными 255 или превышающими это значение, используются внутренними механизмами SQL Server,
							--	такими как планировщик выделенных административных соединений. Не допускает значения NULL.
	 , cpu_id				--Идентификатор ЦП, присвоенный планировщику. Не допускает значения NULL.
	 , parent_node_id		--Идентификатор узла, к которому относится планировщик; этот узел еще называют родительским.
							--Он является узлом с неоднородным доступом к памяти (NUMA). Не допускает значения NULL.
	 , current_tasks_count	--Количество задач, ассоциированных в настоящий момент с данным планировщиком. Этот счетчик включает:
							--задачи, ожидающие исполнителя, который бы их выполнил;
							--задачи, ожидающие выполнения или выполняющиеся в данный момент (находящиеся в состоянии SUSPENDED или RUNNABLE).
							--При завершении задачи этот счетчик уменьшается. Не допускает значения NULL.
	 , runnable_tasks_count	--Количество исполнителей с назначенными задачами, которые ожидают назначения в очереди готовых к работе. Не допускает значения NULL.
	 , current_workers_count--Количество исполнителей, ассоциированных с данным планировщиком. В их число входят исполнители, которым не назначена никакая задача. 
							--Не допускает значения NULL.
	 , active_workers_count	--Количество активных исполнителей. Активный исполнитель никогда не работает в режиме с вытеснением; 
							--он должен иметь связанную с ним задачу и либо работает, либо готов к выполнению, либо приостановлен. 
							--Не допускает значения NULL.
	 , work_queue_count		--Число задач в очереди на выполнение. Это задачи, ожидающие исполнителя, который бы их выполнил. Не допускает значения NULL.
	 , pending_disk_io_count--Число операций ввода-вывода, ожидающих завершения. Каждый планировщик имеет список незавершенных операций ввода-вывода, 
							--	проверяя при каждом переключении контекста, не завершены ли они. 
							--Этот счетчик увеличивается при поступлении запроса и уменьшается при завершении обработки запроса. 
							--Он не характеризует состояние операций ввода-вывода. Не допускает значения NULL.
	 , load_factor			--Внутреннее значение, характеризующее нагрузку на планировщик. Оно используется для распределения задач между планировщиками. 
							--Это значение может оказаться полезным при отладке в случае неравномерного распределения нагрузки между планировщиками. 
							--Решение о маршрутизации выполняется в зависимости от загрузки планировщика. 
							--Кроме того, для определения наилучшего источника ресурсов в SQL Server используется фактор нагрузки на узлы и планировщики. 
							--Когда задача помещается в очередь, фактор нагрузки увеличивается. Когда задача завершается, фактор нагрузки уменьшается. 
							--Факторы нагрузки помогают операционной системе SQL Server эффективнее выполнять балансирование нагрузки. Не допускает значения NULL.
	 , is_online			--Если SQL Server настроен на использование лишь некоторых доступных на сервере процессоров, 
							--	некоторые планировщики могут быть сопоставлены с процессорами, не указанными в маске схожести. 
							--Если это так, то этот столбец вернет 0. Это значение означает, что планировщик не используется для обработки запросов или пакетов.
							--Не допускает значения NULL.
	, is_idle				--1 = планировщик находится в состоянии простоя. В настоящий момент не запущен ни один из исполнителей. Не допускает значения NULL.
	, failed_to_create_worker--Это значение устанавливается в 1, если на данном планировщике не удалось создать новый исполнитель. 
							 --Как правило, это происходит из-за недостатка памяти. Допускает значение NULL.
FROM sys.dm_os_schedulers
WHERE scheduler_id < 255

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Возвращает по одной строке для каждого планировщика SQL Server, сопоставленного с отдельным процессором', @level0type = N'SCHEMA', @level0name = N'inf', @level1type = N'VIEW', @level1name = N'vSchedulersOS';
