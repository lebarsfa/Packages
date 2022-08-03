#include <iostream>
#include <opencv2/core.hpp>

int main(int argc, char* argv[])
{
	cv::Mat M(2, 2, CV_8UC3, cv::Scalar(0, 0, 255));
	std::cout << "cv::Mat M = " << std::endl << " " << M << std::endl << std::endl;
	return 0;
}
