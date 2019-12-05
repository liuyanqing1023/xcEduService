package com.xuecheng.test.algorithm;

/**
 * @ClassName Store
 * @Description Store
 * @Author itdlyq01
 * @Date 2019/11/27 16:47
 */
public class Store {


    public static void main(String[] args) {
        Object o = new Object();
        Store store = new Store();
        int[] arr = new int[]{12,2,45,5,7,2,3,6,9};
        int[] ints = store.bubbleSort(arr);

        for (int a:
                ints) {
            System.out.println(a);
        }
    }


    public int[] bubbleSort(int[] a) {
        int n = a.length;
        if (n<=1) {
            return a;
        }
        for (int i = 0; i < n; i++) {
            //提前退出冒泡循环的标志
            boolean flag = false;
            for (int j = 0; j < n-i-1; j++) {
                if (a[j]>a[j+1]) {//
                    int temp = a[j];
                    a[j] = a[j+1];
                    a[j+1] = temp;

                    flag = true;//表示有数据交换
                }
                if (!flag) {
                    break; //没有数据交换(说明已排好序无需再进行冒泡),提前退出
                }
            }
        }
        return a;
    }

}
