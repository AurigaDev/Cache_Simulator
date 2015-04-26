//   File: cache_sim.c
// Author: Ryan Vrecenar
//         Texas A and M University
//   Date: 4/19/2015

// Preprocessor Directives

#define FILENAME "../spim/Atrace.txt"
#define SEED 0 					// used in random replacement policy
// Includes

#include <stdio.h>				// printf, file io, NULL
#include <math.h> 				// log
#include <stdlib.h> 			// srand, rand

FILE * qp;						// used in cache behavior output debugging

//######################################## Replacement Functions ##############################################
void update_priority(unsigned int i, unsigned int start, unsigned int end,unsigned int replacement, int * priority){
	int j;
	if(replacement == 0)	//MRU
		priority[0] = i;
	else if(replacement == 1){	//LRU
		
		for(j = start; j < end; j++){
			priority[j]+=1;
		}
		priority[i]=0;
		return;
	}	
	else if(replacement == 2)	//Random
		return;	
}

int retrieve_priority(unsigned int start,unsigned int end,unsigned int replacement, int * priority){
	if(replacement == 0)		// MRU
		return priority[0];
	else if(replacement == 1){	// LRU
		
		int j,max = start ;
		for(j = start + 1; j < end; j++){
			if(priority[j] > priority[max]){
				max = j;
			}	
		}
		return max;
	}	
	else if(replacement == 2){	// Random
		int random_int = rand() % end;
		return random_int;
	}	

}


//######################################## Placement Policies ##############################################

// Direct-Mapped Cache Access
int Direct_access(int mem_addr,int * cache, int no_blocks, int line_size ){
	// 			address  >>     block offset    >> 
	int tag = mem_addr >> (int)(log(no_blocks)/log(2)) >> (int)(log(4*line_size)/log(2));
	int index = (mem_addr / (line_size * 4) )% no_blocks;
	if(cache[index] == tag) {
		return 1;
	}	
	cache[index] = tag;
	return 0;
}

// Fully-Associative Cache Access
int Fully_assoc_access(int mem_addr,int * cache, int replacement,
						int no_blocks, int line_size,int * priority ){
	int tag = mem_addr >>(int)(log(4*line_size)/log(2));
	int pre_exist = -1;
	// search for tag already in cache
	int i;
	fprintf(qp,"address: %X! (tag %X) \n", mem_addr,tag );
	for(i = 0; i < no_blocks; i++){
		if(cache[i] == tag )
			pre_exist = i;
	}
	// entry already exists in cache line
	if(pre_exist >= 0){
		update_priority(pre_exist,0,no_blocks,replacement, priority);
		fprintf(qp,"Trying block %i tag %X -- HIT\n", pre_exist, tag);
		return 1;
	}
	else{
		// search for a block with valid bit
		for(i = 0; i < no_blocks; i++){
			if(cache[i] == -1){
				update_priority(i,0,no_blocks,replacement, priority);
				fprintf(qp,"Trying block %i empty -- MISS\n", i, tag);
				cache[i] = tag;
				return 0;
			}
			fprintf(qp,"Trying block %i tag %X -- OCCUPIED\n", i, tag);
		}	
		//get an index to replace
		int replace_index = retrieve_priority(0,no_blocks,replacement, priority);
		update_priority(replace_index,0,no_blocks,replacement, priority);
		fprintf(qp,"REPLACING %X! Looking for %X! index %i\n", mem_addr,tag , replace_index);
		cache[replace_index] = tag;
		return 0;
	}
}

// N Ways-Associative Cache Access
int N_assoc_access(int mem_addr,int * cache, int replacement, int no_blocks,
							   int set_size, int line_size,int * priority ){
	
	int tag = mem_addr >> (int)(log(no_blocks)/log(2))-set_size >> (int)(log(4*line_size)/log(2));
	int set = ((mem_addr >> (int)(log(4*line_size)/log(2))) % (no_blocks/(int)pow(2,set_size)));
	int offset = mem_addr % line_size*4;
	
	int pre_exist = -1;
	// search for tag already in cache
	int i;
	
	fprintf(qp,"address: %X! (tag %X) \n", mem_addr,tag );
	
	int start = (int)pow(2,set_size)*set;
	fprintf(qp,"offset %i, set %i, start %i, end %i\n", offset, set, start, start+(int)pow(2,set_size));
	
	for(i = start; i < start+(int)pow(2,set_size); i++){
		if(cache[i] == tag )
			pre_exist = i;
	}
	// entry already exists in cache line
	if(pre_exist >= 0){
		update_priority(pre_exist,start,start+(int)pow(2,set_size),replacement, priority);
		fprintf(qp,"Trying block %i tag %X -- HIT\n", pre_exist, tag);
		return 1;
	}
	else{
		// search for a block with valid bit
		// start + sets
		start = (int)pow(2,set_size)*set;
		for(i = start; i < start+pow(2,set_size); i++){
			if(cache[i] == -1){
				update_priority(i,start,start+(int)pow(2,set_size),replacement, priority);
				fprintf(qp,"Trying block %i empty -- MISS\n", i, tag);
				cache[i] = tag;
				return 0;
			}
			fprintf(qp,"Trying block %i tag %X -- OCCUPIED\n", i, tag);
		}	
		//get an index to replace
		start = (int)pow(2,set_size)*set;
		int replace_index = retrieve_priority(start,start+pow(2,set_size),replacement, priority);
		update_priority(replace_index,start,start+(int)pow(2,set_size),replacement, priority);
		fprintf(qp,"REPLACING %X! Looking for %X! index %i\n", mem_addr,tag , replace_index);
		cache[replace_index] = tag;
		return 0;
	}
}

// Member Functions

unsigned int file_line_number(char * filename){
	unsigned int curr_char,		// current character of input file for counting line numbers
			     no_lines= 0;	// number of lines in input file
	
	FILE *fp;
	fp=fopen(FILENAME, "r");	
	
	while ( ( curr_char = fgetc(fp)) != EOF )
        if (  curr_char == 0x0A ) no_lines++;
	
	fclose(fp);
	
	return no_lines;
}

void fill_mem_accesses(char * filename, int * mem){
	int addr;		// int representation of an address
	char line[80],	// data structure to save current string
	trim_addr[80]; 	//data structure to remove prefixes
	
	FILE * fp=fopen(filename, "r");
	
	int i = 0;
	
	//parse input file and strip integer representation of addresses
	while (fscanf(fp, "%s", line) != EOF) {
		int c = 0;
		char trim_addr[80];
		while (c < 8) {
			trim_addr[c] = line[c+2];
			c++;
		}
		trim_addr[c] = '\0';
		sscanf(trim_addr, "%x", &addr);
		mem[i] = addr;
		i+=1;
	}
	fclose(fp);
}

int cache_access(int mem_addr,int * cache,int placement,int replacement,
		   int no_blocks,int set_size,int line_size, int * priority ){
	switch(placement){
		case 0: 
			return Direct_access(mem_addr, cache, no_blocks, line_size);
			break;
		case 1:
			return Fully_assoc_access(mem_addr,cache,replacement,no_blocks,line_size, priority);
			break;
		case 2:
			return N_assoc_access(mem_addr,cache,replacement,no_blocks,set_size,line_size, priority);
			break;	
	}	
}

// Main

int main(){
	srand(SEED);
	qp =fopen("cache_bahavior.txt", "w");
	// number of memory accesses		
	unsigned int no_lines = file_line_number("../spim/Atrace.txt");
	
	// array of all memory access to traverse through	
	int mem_accesses [no_lines];

	// parse Atrace.txt for all memory accesses read and write
	fill_mem_accesses(FILENAME, mem_accesses);
	
	/*
	Input Parameters
		Placement Policy: "Direct" "Fully" "N-Ways"
		Replacement Policy: "LRU" "Random" "Bélády's Algorithm" "MRU"
							http://en.wikipedia.org/wiki/Cache_algorithms
		Number of Blocks: Exponents of two up to a certain point (2048)
		Block Size: (Fully) Number of blocks (N-Ways) Exponents of two up to number of blocks (Direct) One
		Line Size: Exponents of two up to a certain point (2048) in number of words. 4 bytes per block size
	Derived Size = (Line Size * 4) * (Number of Blocks) Bytes
	*/ 	
	
	// input parameters
	int  placement = 2,			// 0 for direct, 1 for fully, 2 for N-ways
 	   replacement = 1,			// 0 for MRU, 1 for LRU, 2 for random
	     no_blocks = 16,		// number of containers for addresses
	      set_size = 1,			// 2^i number of sets each address can associate to
		 line_size = 16;			// size of a line in cache
	
	// embedded rules
		if(placement == 0)
			set_size = 0;	// 1 set per block in direct
		if(placement == 1)
			set_size = (int)log(no_blocks)/log(2);	// every set per block in fully
		if(placement == 2)
			if(pow(2,set_size) > no_blocks)
				set_size = (int)(log(no_blocks)/log(2));	// n sets pet blocks
	
	// array of cache values, initialized to -1 signifying empty
	int cache[no_blocks];
	// array of cache related values such as MRU or LRU
	int cache_priority[no_blocks+1];
	
	int j;
	for (j = 0; j < no_blocks; ++j)
		 cache[j] = -1;
	 
	for (j = 0; j < no_blocks; ++j)
		 cache_priority[j] = 0;
	
	int total=0;
	int i;
	
	printf("no_blocks %i,set_size %i, line_size %i\n",no_blocks, (int)pow(2,set_size), line_size*4);
	
	for(i = 0; i < no_lines; i++)//for(i = 0; i < 15; i++)
		total += cache_access(mem_accesses[i],cache, placement, replacement, no_blocks, set_size, line_size, cache_priority );
	printf("Cache Accesses: %i\nCache Hits: %i\nCache Misses: %i\nCache Hit Rate: %.2f%%\n",i,total,i-total,(double)total/i *100);
	fclose(qp);
	return 0;
}