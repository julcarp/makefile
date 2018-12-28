#make_it_all: filter_test simple_test tree_insert_test p2-tests

#test: filter_test simple_test tree_insert_test p2-tests
	#./simple_test > simple_test.out
	#diff simple_test.out simple_test.out.correct
	#./filter_test
	#./tree_insert_test
	#./p2-tests
#	@echo "---All tests passed---"

#simple_test: $(gcc -MM simple_test.cpp)
#	gcc -Wall -Werror -pedantic -O2 \
#	      -MM simple_test.cpp -o simple_test

#compiler
CXX = g++

#compiler flags
CXXFLAGS = -Wall -Werror -pedantic -O2

#list of sources
SOURCES = p2.cpp Binary_tree.cpp Recursive_list.cpp recursive.cpp simple_test.cpp test_helpers.cpp

#list of objects
OBJECTS = $(SOURCES:%.cpp=%.o)

#list of prereqs
PREREQS = $(SOURCES:%.cpp=%.d)

#simple_test: $(OBJECTS)
#	$(CXX) $(CXXFLAGS) $(OBJECTS) -o simple_test

#rule for creating objects
#%.o: %.cpp
#	$(CXX) $(CXXFLAGS) -c $*.cpp

#rule for creating prereqs
%.d: %.cpp
	@ $(CXX) -MM $(CXXFLAGS) $*.cpp | sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' > $@

#-include $(PREREQS)

simple_test: $(OBJECTS)
	$(CXX) $(CXXFLAGS) $(OBJECTS) -o simple_test

-include $(PREREQS)


#####Dependecy stuff that apparently doesn't work#######
#gcc -MM simple_test.cpp


#filter_test: filter_test.cpp p2.cpp Recursive_list.cpp Binary_tree.cpp \
#	      recursive.cpp test_helpers.cpp
#	g++ -Wall -Werror -pedantic -O2 \
	      filter_test.cpp p2.cpp Recursive_list.cpp Binary_tree.cpp \
	      recursive.cpp test_helpers.cpp -o filter_test

#tree_insert_test: tree_insert_test.cpp p2.cpp Recursive_list.cpp Binary_tree.cpp \
	      recursive.cpp test_helpers.cpp
#	g++ -Wall -Werror -pedantic -O2 \
	      tree_insert_test.cpp p2.cpp Recursive_list.cpp Binary_tree.cpp \
	      recursive.cpp test_helpers.cpp -o tree_insert_test

#p2-tests: p2-tests.cpp p2.cpp Recursive_list.cpp Binary_tree.cpp \
	      recursive.cpp test_helpers.cpp
#	g++ -Wall -Werror -pedantic -O2 \
	      p2-tests.cpp p2.cpp Recursive_list.cpp Binary_tree.cpp \
	      recursive.cpp test_helpers.cpp -o p2-tests

#tar: p2.cpp p2-tests.cpp group.txt
#	tar -czf submit.tar.gz p2.cpp p2-tests.cpp group.txt
#
.PHONY: clean
clean:
	rm -vf p2-tests filter_test simple_test tree_insert_test *.out
