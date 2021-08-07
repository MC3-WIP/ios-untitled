//
//  TaskDetailWaitingOwenerReviewView.swift
//  monitool
//
//  Created by Mac-albert on 06/08/21.
//

import SwiftUI

struct OwnerReviewView: View {
    
    @StateObject var taskDetailViewModel: TaskDetailViewModel
    
    init (task: Task){
        _taskDetailViewModel = StateObject(wrappedValue: TaskDetailViewModel(task: task))
    }
    
    private let totalPage: Int = 3
    private let notes = "Sudah Pak Bos"
    private let pic = "Mawar"
    
    @State private var comment: String = ""
    @State var proofPage = 0
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    VStack(){
                        Text(taskDetailViewModel.task.name)
                            .font(.system(size: 28, weight: .bold))
                            .padding(.vertical, 24.0)
                            .frame(minWidth: 100, maxWidth: .infinity, minHeight: 28, maxHeight: 32, alignment: .leading)
                        Image("kucing1")
                            .resizable()
                        if let desc = taskDetailViewModel.task.desc{
                            Text(desc)
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.system(size: 17))
                                .multilineTextAlignment(.leading)
                        }
                        Spacer()
                        Button(action: {
                            // MARK: ACTION BUTTON REVISE
                        }){
                            HStack{
                                Image(systemName: "repeat")
                                Text("Revise")
                            }
                            //                            .frame(minWidth: 0, maxWidth: metric.size.width * 0.85, minHeight: 50, maxHeight: 50)
                            .font(.system(size: 28))
                            .padding()
                            .foregroundColor(Color(hex: "#4FB0AB"))
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(hex: "#4FB0AB"), lineWidth: 2)
                            )
                        }
                    }
                    VStack(spacing: 8){
                        Text("Proof of Work")
                            .padding(.bottom, 8)
                            .font(.system(size: 20, weight: .bold))
                            //                            .frame(minWidth: 100, maxWidth: .infinity, minHeight: 20, maxHeight: 24, alignment: .leading)
                            .foregroundColor(Color(hex: "898989"))
                        VStack{
                            ZStack{
                                switch proofPage{
                                case 0:
                                    ProofOfWork(image: "kucing2", date: "21 Jul 2021 at 15:57")
                                case 1:
                                    ProofOfWork(image: "kucing3", date: "21 Jul 2021 at 15:57")
                                case 2:
                                    ProofOfWork(image: "kucing4", date: "21 Jul 2021 at 15:57")
                                default:
                                    Text("Error")
                                }
                            }
                            .highPriorityGesture(DragGesture(minimumDistance: 25, coordinateSpace: .local)
                                                    .onEnded { value in
                                                        if abs(value.translation.height) < abs(value.translation.width) {
                                                            if abs(value.translation.width) > 50.0 {
                                                                if value.translation.width > 0 {
                                                                    if proofPage == 0{
                                                                        
                                                                    }
                                                                    else{
                                                                        proofPage -= 1
                                                                    }
                                                                }
                                                                else if value.translation.width < 0 {
                                                                    if proofPage == totalPage - 1 {
                                                                        
                                                                    }
                                                                    else{
                                                                        proofPage += 1
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                            )
                            PageControl(totalPage: totalPage, current: proofPage)
                            
                        }
                        //                        .frame(width: matric.size.width * 0.75)
                        .padding(.top, 10)
                        .background(Color(hex: "F0F9F8"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color(hex: "4EB0AB"), lineWidth: 1)
                        )
                        HStack{
                            Text("PIC: ")
                                .foregroundColor(Color(hex: "6C6C6C"))
                                .font(.system(size: 17, weight: .bold))
                            Text(taskDetailViewModel.pic?.name ?? "-")
                        }
                        //                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 21, alignment: .leading)
                        //                        .padding(.top, 27)
                        HStack{
                            Text("Notes: ")
                                .foregroundColor(Color(hex: "6C6C6C"))
                                .font(.system(size: 17, weight: .bold))
                            Text(taskDetailViewModel.task.notes ?? "-")
                        }
                        //                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 21, alignment: .leading)
                        //                        .padding(.vertical, 20)
                        Spacer()
                        VStack{
                            Text("Comment: ")
                                .foregroundColor(Color(hex: "6C6C6C"))
                                .font(.system(size: 20, weight: .bold))
                            //                                .frame(width: matric.size.width * 0.9, height: 25, alignment: .leading)
                            TextField("Type your Comment Here", text: $comment)
                                .multilineTextAlignment(.leading)
                                //                                .frame(width: matric.size.width * 0.90, height: 110, alignment: .center)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color(hex: "4EB0AB"), lineWidth: 1)
                                )
                        }
                        Spacer()
                        Button(action: {
                            // MARK: ACTION BUTTON REVISE
                        }){
                            HStack{
                                Image(systemName: "checkmark")
                                Text("Approve")
                            }
                            //                            .frame(minWidth: 0, maxWidth: matric.size.width * 0.85, minHeight: 50, maxHeight: 50)
                            .font(.system(size: 28))
                            .padding()
                            .foregroundColor(Color.white)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(hex: "#4FB0AB"), lineWidth: 2)
                            ).background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: "#4FB0AB")))
                        }
                    }
                }
            }
            
        }
        .navigationBarTitle(taskDetailViewModel.task.name, displayMode: .large)
    }
    @ViewBuilder
    func ProofOfWork(image: String, date: String) -> some View{
        VStack{
            Image(image)
//                .scaledToFit()
                .resizable()
            //                .frame(width: metricSize.size.width * 0.7, height: metricSize.size.width * 0.7)
            Text("21 Jul 2021 at 15:57")
                .font(.system(size: 11))
            //                .frame(width: metricSize.size.width * 0.7, height: 12, alignment: .leading)
        }
    }
}

struct TaskDetailWaitingOwenerReviewView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerReviewView(task: Task(name: "OwnerReview"))
            .previewDevice("iPad Pro (12.9-inch) (5th generation)")
            .previewLayout(.fixed(width: 1112, height: 834))
    }
}
