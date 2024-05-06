//
//  PostPreviewView.swift
//  GeoStream
//
//  Created by Matthew Dowling on 5/3/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostPreviewView: View {
    @EnvironmentObject private var mapVM: MapViewModel
    let post: Post
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                titleSection
            }
            
            VStack(spacing: 8) {
                viewPostButton
                if mapVM.nearestPosts.contains(post) {
                    nextButton
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
        .cornerRadius(10)
    }
}


extension PostPreviewView {
    private var imageSection: some View {
        ZStack {
            if let _ = post.getFirstPhotoURL() {
                ZStack {
                    PostImageView(post: post)
                        .frame(width: 100, height: 100)
                        .scaledToFit()
                    .cornerRadius(10)
                }
                .padding(6)
                .background(Color.white)
                .cornerRadius(10)
            } else {
                MapPinView(type: post.type)
                    .frame(width: 100, height: 100)
                    .scaledToFill()
                .cornerRadius(10)
            }
        }

    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(post.city)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(post.state)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var viewPostButton: some View {
        Button {
            mapVM.openedPost = post
        } label: {
            Text("View post")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View {
        Button {
            mapVM.nextButtonPressed()
        } label: {
            Text("Next result")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.bordered)
    }
    
}
