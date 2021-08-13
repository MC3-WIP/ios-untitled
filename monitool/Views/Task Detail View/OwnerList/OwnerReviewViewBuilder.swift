//
//  OwnerReviewViewBuilder.swift
//  monitool
//
//  Created by Mac-albert on 08/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

extension OwnerReviewView{
    @ViewBuilder func LeftColumn() -> some View {
        GeometryReader{ metric in
            VStack{
                Text(taskDetailViewModel.task.name)
                    .font(.system(size: 28, weight: .bold))
                    .frame(minWidth: 100, maxWidth: .infinity, minHeight: 28, maxHeight: 32, alignment: .leading)
                WebImage(url: URL(string: OwnerViewModel.task.photoReference ?? ""))
                    .resizable()
                    .frame(width: metric.size.width * 0.8, height: metric.size.width * 0.8, alignment: .leading)
                if let desc = taskDetailViewModel.task.desc{
                    Text(desc)
                        .frame(width: metric.size.width * 0.8, alignment: .topLeading)
                        .font(.system(size: 17))
                        .multilineTextAlignment(.leading)
                }
            }
            .padding()
        }
    }
    @ViewBuilder
    func ProofOfWork(image: String, date: String, metricSize: GeometryProxy, datePhoto: String) -> some View{
        VStack{
            Image(image)
                .resizable()
                .frame(width: metricSize.size.width * 0.7, height: metricSize.size.width * 0.7)
            Text(datePhoto)
                .font(.system(size: 11))
                .frame(width: metricSize.size.width * 0.7, height: 12, alignment: .leading)
        }
    }
    
    @ViewBuilder func RightColumn() -> some View{
        GeometryReader{ matric in
            VStack{
                Text("Proof of Work")
                    .padding(.bottom, 8)
                    .font(.system(size: 20, weight: .bold))
                    .frame(minWidth: 100, maxWidth: .infinity, minHeight: 20, maxHeight: 24, alignment: .leading)
                    .foregroundColor(Color(hex: "898989"))

                proofOfWorkComponent(matric: matric, proofPage: proofPage, totalPage: totalPage, datePhoto: datePhoto)
                
                VStack(spacing: 4){
                    HStack{
                        Text("PIC: ")
                            .foregroundColor(Color(hex: "6C6C6C"))
                            .fontWeight(.bold)
                        Text(taskDetailViewModel.pic?.name ?? "-")
                    }
                    .frame(width: matric.size.width * 0.9, alignment: .leading)
                    HStack{
                        Text("Notes: ")
                            .foregroundColor(Color(hex: "6C6C6C"))
                            .fontWeight(.bold)
                        Text(taskDetailViewModel.task.notes ?? "-")
                    }
                    .frame(width: matric.size.width * 0.9, alignment: .leading)
                }
                .font(.system(size: 17))
                .padding(.vertical, 15)
                
                VStack{
                    Text("Comment: ")
                        .foregroundColor(Color(hex: "6C6C6C"))
                        .font(.system(size: 20, weight: .bold))
                        .frame(width: matric.size.width * 0.9, height: 25, alignment: .leading)
                    TextField("Add notes here", text: $OwnerViewModel.notesText)
                        .padding()
                        .frame(width: matric.size.width * 0.9, height: 120, alignment: .top)
                        .background(Color(hex: "F0F9F8"))
                        .modifier(RoundedEdge(width: 2, color: AppColor.accent, cornerRadius: 8))
                }
            }
            .padding()
        }
    }
    
    @ViewBuilder func CustomText(title: String, content: String?) -> some View {
        HStack{
            Text(title)
                .foregroundColor(Color(hex: "6C6C6C"))
                .font(.system(size: 17, weight: .bold))
            Text(content ?? "-")
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
    @ViewBuilder func proofOfWorkComponent(matric: GeometryProxy, proofPage: Int, totalPage: Int, datePhoto: String) -> some View {
            VStack{
                ZStack{
                    switch proofPage{
                    case 0:
                        ProofOfWork(image: "kucing2", date: "21 Jul 2021 at 15:57", metricSize: matric, datePhoto: datePhoto)
                    case 1:
                        ProofOfWork(image: "kucing3", date: "21 Jul 2021 at 15:57", metricSize: matric, datePhoto: datePhoto)
                    case 2:
                        ProofOfWork(image: "kucing4", date: "21 Jul 2021 at 15:57", metricSize: matric, datePhoto: datePhoto)
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
                                        self.proofPage -= 1
                                    }
                                }
                                else if value.translation.width < 0 {
                                    if proofPage == totalPage - 1 {
                                        
                                    }
                                    else{
                                        self.proofPage += 1
                                    }
                                }
                            }
                        }
                    }
                )
                PageControl(totalPage: totalPage, current: proofPage)
            }
            .frame(width: matric.size.width * 0.75)
            .padding(.top, 10)
            .background(Color(hex: "F0F9F8"))
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color(hex: "4EB0AB"), lineWidth: 1)
            )
    }
    @ViewBuilder
    func reviseButton() -> some View{
        Button(action: {
            // MARK: ACTION BUTTON REVISE
            taskViewModel.updateStatus(id: taskDetailViewModel.task.id, status: TaskStatus.revise.title)
            self.presentationMode.wrappedValue.dismiss()
        }){
            HStack{
                Image(systemName: "repeat")
                Text("Revise")
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .font(.system(size: 17, weight: .semibold))
            .padding()
            .foregroundColor(Color(hex: "#4FB0AB"))
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(hex: "#4FB0AB"), lineWidth: 2)
                            )
        }
    }
    func approveButton() -> some View{
        Button(action: {
            // MARK: ACTION BUTTON APPROVE
            taskViewModel.updateStatus(id: taskDetailViewModel.task.id, status: TaskStatus.completed.title)
            self.presentationMode.wrappedValue.dismiss()
        }){
            HStack{
                Image(systemName: "checkmark")
                Text("Approve")
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .font(.system(size: 17, weight: .semibold))
            .padding()
            .foregroundColor(Color.white)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(hex: "#4FB0AB"), lineWidth: 2)
            ).background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: "#4FB0AB")))
        }
    }
}
