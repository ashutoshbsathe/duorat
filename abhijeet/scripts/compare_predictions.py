import os

# file_1 = sys.argv[0]
# file_2 = sys.argv[1]
# output_file = sys.argv[2]

root = '/mnt/a99/d0/awasthi/repos/Text2SQL/duoleo'

file_1 = os.path.join(root,'logdir/duorat-finetune-bert-large-only_spider/output_oneshot.json')
file_2 = os.path.join(root,'logdir/duorat-finetune-spider-bert-large-on-geo-oneshot/output.json')
output_file = os.path.join(root,'comparison.txt')


def get_execution_from_para(para):
	lines = para.split('\n')
	exec_line = [item for item in lines if 'Execution was correct?' in item]
	assert len(exec_line) <= 1
	if len(exec_line) == 1:
		exec_line = exec_line[0]
		exec_result = exec_line.split()[-1]
		return exec_result
	return 'True'

def read_paras(f):
	paras = f.read().strip().split('\n\n')
	executions = [get_execution_from_para(item) for item in paras]
	return paras, executions

with open(file_1) as f1, open(file_2) as f2, open(output_file,'w') as fo:
	paras_1, execs_1 = read_paras(f1)
	paras_2, execs_2 = read_paras(f2)

	improved_para_ids = [i for i,(e1,e2) in enumerate(zip(execs_1, execs_2)) if e1=='False' and e2=='True']
	worsened_para_ids = [i for i,(e1,e2) in enumerate(zip(execs_1, execs_2)) if e1=='True' and e2=='False']

	fo.write(' ***** IMPROVED **** \n\n')
	for i,(p1,p2) in enumerate(zip(paras_1,paras_2)):
		if i in improved_para_ids:
			fo.write('\t\t\t###  ORIGINAL  ###\n')
			fo.write(paras_1[i])
			fo.write('\n\n')
			fo.write('\t\t\t### AFTER ADAPTATION ###\n')
			fo.write(paras_2[i])
			fo.write('\n\n-----------------------\n\n')

	fo.write(' ***** WORSENED **** \n\n')
	for i,(p1,p2) in enumerate(zip(paras_1,paras_2)):
		if i in worsened_para_ids:
			fo.write('\t\t\t###  ORIGINAL  ###\n')
			fo.write(paras_1[i])
			fo.write('\n\n')
			fo.write('\t\t\t###  AFTER ADAPTATION  ###\n')
			fo.write(paras_2[i])
			fo.write('\n\n-----------------------\n\n')

print('TOTAL: ', len(paras_1)-1)
print('IMPROVED: ', len(improved_para_ids))
print('WORSENED: ', len(worsened_para_ids))
print('PERCENT IMPROVED: ', (len(improved_para_ids)/(len(paras_1)-1))*100)
print('PERCENT WORSENED: ', (len(worsened_para_ids)/(len(paras_1)-1))*100)


